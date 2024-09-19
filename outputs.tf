output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_app_subnet_ids
}

# output "internet_gateway_id" {
#   value = module.internet_gateway.internet_gateway_id
# }

# output "nat_gateway_ids" {
#   value = module.nat_gateways.nat_gateway_ids
# }

# output "security_group_ids" {
#   value = module.security_groups.security_group_ids
# }

# output "ec2_instance_ids" {
#   value = module.ec2_instances.instance_ids
# }

# output "rds_endpoint" {
#   value = module.rds.rds_endpoint
# }

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}



output "acm_certificate_arn" {
  value = module.acm_certificate.certificate_arn
}