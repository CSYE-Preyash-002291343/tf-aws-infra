resource "aws_db_parameter_group" "postgres" {
  name        = "csye6225-${var.environment}"
  family      = "postgres16"
  description = "Default parameter group for ${var.environment}"
  parameter {
    name         = "shared_preload_libraries"
    value        = "pg_stat_statements"
    apply_method = "pending-reboot"
  }
  parameter {
    name         = "rds.force_ssl"
    value        = "0"
    apply_method = "pending-reboot"
  }
  
  tags = {
    Name = "RDS-ParamGroup-${var.environment}"
  }
}