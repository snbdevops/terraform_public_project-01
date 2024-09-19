resource "aws_db_instance" "primary" {
  instance_class         = "db.t2.micro"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  username               = "admin"
  password               = "password" # Change this to a secure value
  db_subnet_group_name   = aws_db_subnet_group.this.name
  multi_az               = true
  publicly_accessible    = false
  vpc_security_group_ids = [var.security_group_id]
  tags = {
    Name = "Primary RDS Instance"
  }
}

resource "aws_db_instance" "standby" {
  instance_class         = "db.t2.micro"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  username               = "admin"
  password               = "password" # Change this to a secure value
  db_subnet_group_name   = aws_db_subnet_group.this.name
  multi_az               = true
  publicly_accessible    = false
  vpc_security_group_ids = [var.security_group_id]
  tags = {
    Name = "Standby RDS Instance"
  }
}

resource "aws_db_subnet_group" "this" {
  name       = "my-db-subnet-group"
  subnet_ids = var.subnet_ids
  tags = {
    Name = "DB Subnet Group"
  }
}