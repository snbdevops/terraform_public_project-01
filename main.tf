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


# module "s3_bucket" {
#   source      = "./modules/s3_bucket"
#   bucket_name = "surajit-s3-tfstate-bucket" # Replace with your bucket name 
# }

# module "dynamodb_table" {
#   source     = "./modules/dynamodb_table"
#   table_name = "surajit-dynamodb-tflock-table" # Replace with your DynamoDB table name
# }

module "vpc" {
  source = "./modules/vpc"
  name   = "terraform-poc-01"
  cidr   = "10.0.0.0/16"
  public_subnet_cidrs = var.public_subnet_cidrs
  application_subnet_cidrs = var.application_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs
  azs = var.azs
  vpc_id = var.vpc_id
}

# module "subnets" {
#   source = "./modules/subnets"
#   vpc_id = module.vpc.vpc_id
# }