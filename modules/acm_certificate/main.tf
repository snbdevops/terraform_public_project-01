resource "aws_acm_certificate" "this" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  # # Add validation for Route 53
  # domain_validation_options {
  #   domain_name = var.domain_name
  #   hosted_zone_id = var.zone_id
  # }
}

# resource "aws_route53_record" "certificate_validation" {
#   count   = length(aws_acm_certificate.this.domain_validation_options)
#   name    = aws_acm_certificate.this.domain_validation_options[count.index].resource_record_name
#   type    = aws_acm_certificate.this.domain_validation_options[count.index].resource_record_type
#   zone_id = var.zone_id
#   records = [aws_acm_certificate.this.domain_validation_options[count.index].resource_record_value]
#   ttl     = 60
# }

# resource "aws_acm_certificate_validation" "this" {
#   certificate_arn         = aws_acm_certificate.this.arn
#   validation_record_fqdns = aws_route53_record.certificate_validation[*].fqdn
# }

resource "aws_route53_record" "certificate_validation" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      value  = dvo.resource_record_value
    }
  }

  zone_id = var.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.value]
  ttl     = 60
}