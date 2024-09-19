resource "aws_s3_bucket" "state_bucket" {
  bucket = "surajit-s3-tfstate-bucket"

  tags = {
    Name        = "surajit-s3-tfstate-bucket"
    Environment = "Prod"
  }
}

resource "aws_dynamodb_table" "state_lock" {
  name           = "surajit-dynamodb-tflock-table"
  hash_key       = "LockID"
  read_capacity  = 5
  write_capacity = 5
  attribute {
    name = "LockID"
    type = "S"
  }
}

# resource "aws_s3_bucket" "alb_logging" {
#   bucket = "surajit-s3-logging-bucket"
#   region = "ap-south-1"
# }


# module "s3_bucket" {
#   source      = "./modules/s3_bucket"
#   bucket_name = "surajit-s3-tfstate-bucket" # Replace with your bucket name 
# }

# module "dynamodb_table" {
#   source     = "./modules/dynamodb_table"
#   table_name = "surajit-dynamodb-tflock-table" # Replace with your DynamoDB table name
# }

module "vpc" {
  source                   = "./modules/vpc"
  name                     = "terraform-poc-01"
  cidr                     = "10.0.0.0/16"
  public_subnet_cidrs      = var.public_subnet_cidrs
  application_subnet_cidrs = var.application_subnet_cidrs
  database_subnet_cidrs    = var.database_subnet_cidrs
  azs                      = var.azs
  vpc_id                   = var.vpc_id
}

# module "subnets" {
#   source = "./modules/subnets"
#   vpc_id = module.vpc.vpc_id
# }

module "route_tables" {
  source      = "./modules/route_tables"
  vpc_id      = module.vpc.vpc_id
  web_subnets = module.vpc.public_subnet_ids
  app_subnets = module.vpc.private_app_subnet_ids
  db_subnets  = module.vpc.private_db_subnet_ids
}

module "internet_gateway" {
  source         = "./modules/internet_gateway"
  vpc_id         = module.vpc.vpc_id
  route_table_id = module.route_tables.web_route_table_ids
}

module "nat_gateways" {
  source            = "./modules/nat_gateways"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "ec2_instances" {
  source             = "./modules/ec2_instances"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_app_subnet_ids
  instance_type      = var.instance_type
  ami_id             = var.ami_id   # Replace with your AMI ID
  key_name           = var.key_name # Replace with your key name
  security_group_id  = ["module.security_groups.ec2_public_id","module.security_groups.ec2_private_id"]  #var.security_group_id
}

module "rds" {
  source            = "./modules/rds"
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.private_db_subnet_ids
  security_group_id = module.security_groups.rds_id
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  #certificate_arn   = module.acm_certificate.certificate_arn
  security_group_id = module.security_groups.public_alb_id
}

module "asg" {
  source            = "./modules/asg"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  instance_type     = var.instance_type
  ami_id            = "ami-0abcdef1234567890" # Replace with your AMI ID
  key_name          = var.key_name            # Replace with your key name
  security_group_id = module.security_groups.public_alb_id
}

module "route53" {
  source             = "./modules/route53"
  domain_name        = "multicloudyug.com"
  record_name        = "app.multicloudyug.com"
  alb_dns_name       = module.alb.alb_dns_name
  alb_hosted_zone_id = module.alb.public_alb_hosted_zone_id 
}

module "acm_certificate" {
  source      = "./modules/acm_certificate"
  domain_name = "multicloudyug.com"
  zone_id     = module.route53.zone_id
}