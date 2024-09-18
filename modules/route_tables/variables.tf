variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "web_subnets" {
  description = "List of web subnet IDs"
  type        = list(string)
}

variable "app_subnets" {
  description = "List of application subnet IDs"
  type        = list(string)
}

variable "db_subnets" {
  description = "List of database subnet IDs"
  type        = list(string)
}