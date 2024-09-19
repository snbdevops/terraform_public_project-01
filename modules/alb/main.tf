resource "aws_alb" "public" {
  name                       = "dns-name-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.security_group_id]
  subnets                    = var.public_subnet_ids
  enable_deletion_protection = false

  #   idle_timeout {
  #     minutes = 60
  #   }
  enable_http2                     = true
  enable_cross_zone_load_balancing = true
  access_logs {
    bucket  = "your-s3-bucket-name"
    enabled = true
  }
}

resource "aws_alb_target_group" "public" {
  name     = "public-targets"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_alb_listener" "public_http" {
  load_balancer_arn = aws_alb.public.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "OK"
      status_code  = "200"
    }
  }
}