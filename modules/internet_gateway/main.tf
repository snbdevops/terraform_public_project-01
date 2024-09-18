resource "aws_internet_gateway" "this" {
  vpc_id = var.vpc_id

  tags = {
    Name = "my-igw-01"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = var.route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
  
}