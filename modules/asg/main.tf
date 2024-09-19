resource "aws_autoscaling_group" "public" {
  launch_configuration = aws_launch_configuration.public.id
  min_size             = 1
  max_size             = 3
  desired_capacity     = 2
  vpc_zone_identifier  = var.public_subnet_ids
  tag {
    key                 = "Name"
    value               = "Public ASG Instance"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "public" {
  name            = "public-launch-configuration"
  image_id        = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [var.security_group_id]
  lifecycle {
    create_before_destroy = true
  }
}