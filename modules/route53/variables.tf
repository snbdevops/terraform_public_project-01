variable "domain_name" {
  description = "Domain name for Route 53"
  type        = string
}

variable "record_name" {
  description = "Record name for Route 53"
  type        = string
}

variable "alb_dns_name" {
  description = "DNS name of the ALB"
  type        = string
}

variable "alb_hosted_zone_id" {
  description = "Hosted zone ID of the ALB"
  type        = string
}