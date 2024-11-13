resource "aws_db_parameter_group" "tiny_db_pg" {
  name = "tiny-db-param-group"
  family = "postgres16"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_subnet_group" "tiny_db_sg" {
  name = "tiny-db-pri-subnet-group"
  subnet_ids = var.tiny_pub_subnet_ids
}
