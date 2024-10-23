resource "aws_db_instance" "postgres" {
  engine         = var.DB_Engine
  instance_class = var.RDS_INSTANCE
  identifier     = var.identifier

  username = var.DB_USER
  password = var.DB_PASS
  db_name  = var.DB_NAME

  db_subnet_group_name = aws_db_subnet_group.dbSubnetGroup.name

  multi_az            = false
  publicly_accessible = false
  allocated_storage   = 20

  skip_final_snapshot = true

  parameter_group_name   = aws_db_parameter_group.postgres.name
  vpc_security_group_ids = [aws_security_group.RDS-SG.id]

  tags = {
    Name = "RDS-Instance-${var.environment}"
  }
}