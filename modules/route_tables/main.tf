resource "aws_route_table" "web" {
  vpc_id = var.vpc_id

  tags = {
    Name = "web-rt"
  }
}

resource "aws_route_table" "app" {
  vpc_id = var.vpc_id

  tags = {
    Name = "app-rt"
  }
}

resource "aws_route_table" "db" {
  vpc_id = var.vpc_id

  tags = {
    Name = "db-rt"
  }
}

resource "aws_route_table_association" "web" {
  count          = length(var.web_subnets

)
  subnet_id      = element(var.web_subnets, count.index)
  route_table_id = aws_route_table.web.id
}

resource "aws_route_table_association" "app" {
  count          = length(var.app_subnets)
  subnet_id      = element(var.app_subnets, count.index)
  route_table_id = aws_route_table.app.id
}

resource "aws_route_table_association" "db" {
  count          = length(var.db_subnets)
  subnet_id      = element(var.db_subnets, count.index)
  route_table_id = aws_route_table.db.id
}