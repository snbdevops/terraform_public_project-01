output "alb_dns_name" {
  value = aws_alb.public.dns_name
  description = "The DNS name of the public ALB"
}

output "public_alb_hosted_zone_id" {
  value = aws_alb.public.zone_id
  description = "The Hosted Zone ID of the public ALB"
}