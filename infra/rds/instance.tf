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
  subnet_ids = var.tiny_subnet_ids
}

resource "aws_rds_cluster" "tiny_postgres_cluster" {
  cluster_identifier = "tiny-postgres-cluster"
  engine_mode = "provisioned"
  engine = data.aws_rds_engine_version.tiny_pstgres_engine.engine
  engine_version = data.aws_rds_engine_version.tiny_pstgres_engine.version
  storage_type = "io1"
  allocated_storage = 100
  iops = 1000
  master_username = "tiny"
  master_password = "rootpass"
  availability_zones = var.availability_zones
  db_subnet_group_name = aws_db_subnet_group.tiny_db_sg.name
  db_instance_parameter_group_name = aws_db_parameter_group.tiny_db_pg.name
}

resource "aws_rds_cluster_instance" "tiny_postgres_cluster_instance" {
  count = 2
  identifier = "tiny-postgres-cluster-instance"
  cluster_identifier = aws_rds_cluster.tiny_postgres_cluster.id
  engine = data.aws_rds_engine_version.tiny_pstgres_engine.engine
  engine_version = data.aws_rds_engine_version.tiny_pstgres_engine.version
  instance_class = "db.t3.micro"
}

# resource "aws_db_instance" "tiny_postgres_instance" {
#   db_name = "tiny-postgresql"
#   instance_class = "db.t3.micro"
#   db_subnet_group_name = aws_db_subnet_group.tiny_db_sg.name
#   username = "tiny"
#   password = "rootpass"
#   engine = data.aws_rds_engine_version.tiny_pstgres_engine.engine
#   engine_version = data.aws_rds_engine_version.tiny_pstgres_engine.version
#   vpc_security_group_ids = var.tiny_sg_ids
#   parameter_group_name = aws_db_parameter_group.tiny_db_pg.name
#   publicly_accessible = true
#   count = 2
# }
