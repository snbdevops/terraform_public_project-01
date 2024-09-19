variable "domain_name" {
  description = "Domain name for the ACM certificate"
  type        = string
}

variable "zone_id" {
  description = "Hosted zone ID for DNS validation"
  type        = string
}

output "certificate_arn" {
  value = aws_acm_certificate.this.arn
}