resource "aws_vpc" "this" {
  cidr_block = var.cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id = var.vpc_id
  cidr_block = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_app" {
  count = length(var.application_subnet_cidrs)
  vpc_id = var.vpc_id
  cidr_block = element(var.application_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "application-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_db" {
  count = length(var.database_subnet_cidrs)
  vpc_id = var.vpc_id
  cidr_block = element(var.database_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "database-subnet-${count.index + 1}"
  }
}



# resource "aws_subnet" "public" {
#   count = 2
#   vpc_id     = aws_vpc.this.id
#   cidr_block  = "10.0.${count.index}.0/24"
#   availability_zone = element(data.aws_availability_zones.available.names, count.index)
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "Public Subnet ${count.index + 1}"
#   }
# }

# resource "aws_subnet" "private_app" {
#   count = 2
#   vpc_id     = aws_vpc.this.id
#   cidr_block  = "10.0.${count.index + 2}.0/24"
#   availability_zone = element(data.aws_availability_zones.available.names, count.index)
#   tags = {
#     Name = "App Subnet ${count.index + 1}"
#   }
# }

# resource "aws_subnet" "private_db" {
#   count = 2
#   vpc_id     = aws_vpc.this.id
#   cidr_block  = "10.0.${count.index + 4}.0/24"
#   availability_zone = element(data.aws_availability_zones.available.names, count.index)
#   tags = {
#     Name = "DB Subnet ${count.index + 1}"
#   }
# }