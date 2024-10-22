resource "aws_db_subnet_group" "dbSubnetGroup" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.private[0].id, aws_subnet.private[1].id]
}