
azs                      = ["ap-south-1a", "ap-south-1b"]
database_subnet_cidrs    = ["10.0.1.0/24", "10.0.5.0/24"]
application_subnet_cidrs = ["10.0.10.0/24", "10.0.15.0/24"]
public_subnet_cidrs      = ["10.0.20.0/24", "10.0.25.0/24"]
vpc_id                   = "vpc-01fb224e64bca7cb8"

ami_id                   = "ami-08718895af4dfa033"
instance_type            = "t2.micro"
#security_group_id        = 

key_name = "terraform-poc-key.pem"