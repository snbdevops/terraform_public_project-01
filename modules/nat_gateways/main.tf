resource "aws_eip" "nat_eip_1" {
  count = 1
}

resource "aws_nat_gateway" "nat_1" {
  allocation_id = aws_eip.nat_eip_1[0].id
  subnet_id     = var.public_subnet_ids[0]
}

resource "aws_eip" "nat_eip_2" {
  count = 1
}

resource "aws_nat_gateway" "nat_2" {
  allocation_id = aws_eip.nat_eip_2[0].id
  subnet_id     = var.public_subnet_ids[1]
}