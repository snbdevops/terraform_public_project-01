variable "subnet_ids" {
  description = "List of DB subnet IDs"


  type = list(string)
}

variable "security_group_id" {
  description = "Security group ID for RDS"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}