terraform {
  backend "s3" {
    bucket         = "surajit-s3-tfstate-bucket" # Replace with your bucket name
    key            = "terraform/statefile.tfstate"
    region         = "ap-south-1"                    # Replace with your region
    dynamodb_table = "surajit-dynamodb-tflock-table" # Replace with your DynamoDB table name
  }
}

provider "aws" {
  region = "ap-south-1" # Replace with your region
}