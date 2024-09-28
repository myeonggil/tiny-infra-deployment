resource "aws_vpc" "tiny_network" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.service_name
  }
}