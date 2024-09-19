resource "aws_route53_zone" "public" {
  name = var.domain_name
}

resource "aws_route53_record" "alb_alias" {
  zone_id = aws_route53_zone.public.id
  name    = var.record_name
  type    = "A"
  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_hosted_zone_id
    evaluate_target_health = true
  }
}