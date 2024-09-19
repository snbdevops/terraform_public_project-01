resource "aws_instance" "public" {
  count           = 2
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = element(var.public_subnet_ids, count.index)
  #key_name        = var.key_name
  security_groups = var.security_group_id
  tags = {
    Name = "Public EC2 Instance ${count.index + 1}"
  }
}

resource "aws_instance" "private" {
  count           = 2
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = element(var.private_subnet_ids, count.index)
  #key_name        = var.key_name
  security_groups = var.security_group_id
  tags = {
    Name = "Private EC2 Instance ${count.index + 1}"
  }
}