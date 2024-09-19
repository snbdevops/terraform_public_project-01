# output "route53_zone_id" {
#   value = aws_route53_zone.public.zone_id
# }

output "dns_record_name" {
  value = aws_route53_record.alb_alias.fqdn
}

# output "route53_zone_id" {
#   value = module.route53.zone_id
# }

output "zone_id" {
  value = aws_route53_zone.public.zone_id  # Reference the actual Route 53 resource
  description = "The ID of the Route 53 hosted zone"
}
