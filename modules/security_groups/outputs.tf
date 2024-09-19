output "public_alb_id" {
  value = aws_security_group.public_alb.id
}

output "private_alb_id" {
  value = aws_security_group.private_alb.id
}

output "ec2_public_id" {
  value = aws_security_group.ec2_public.id
}

output "ec2_private_id" {
  value = aws_security_group.ec2_private.id
}

output "rds_id" {
  value = aws_security_group.rds.id
}