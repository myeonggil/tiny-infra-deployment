provider "aws" {
  profile                  = "infra"
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  region                   = var.region
}

data "aws_availability_zones" "available" {
  state = "available"
}
data "http" "icanhazip" {
  url = "http://icanhazip.com"
}

terraform {
  backend "local" {
    path = "./"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.72.0"
    }
  }
}

# module "network" {
#   source       = "./network"
#   vpc_cidr     = var.vpc_cidr
#   service_name = var.service_name
#   region       = var.region
#   public_your_ip = "${chomp(data.http.icanhazip.response_body)}/32"
# }
# module "compute" {
#   source = "./compute"
#   region = var.region
#   instance_type = var.instance_type
#   service_name = var.service_name
#   tiny_sg_id = module.network.tiny_sg_id
#   tiny_subnet_group_id = module.network.tiny_subnet_group_id
# }
# module "container" {
#   source = "./container"
#   tiny_sg_id = module.network.tiny_nginx_sg_id
#   tiny_subnet_groups_id = module.network.tiny_ecs_subnet_groups
# }
# module "dns" {
#   source = "./dns"
#   service_name = var.service_name
#   domain_name = var.domain_name
#   region = var.region
#   tiny_lb = module.lb.tiny_lb
# }
# module "lb" {
#   source = "./lb"
#   service_name = var.service_name
#   service_id = module.container.service_id
#   certification = module.dns.certification
#   tiny_tg_sg = module.network.tiny_sg_id
#   vpc_id = module.network.vpc_id
#   tiny_subnet_pub_ids = module.network.tiny_subnet_pub_ids
# }
# module "rds" {
#   source = "./rds"
#   tiny_sg_ids = module.network.tiny_rds_sg_id
#   tiny_pub_subnet_ids = module.network.tiny_pub_sub_ids
#   service_name = var.service_name
#   availability_zones = data.aws_availability_zones.available.names
#   region = var.region
# }
# module "iam" {
#   source = "./iam"
#   users = var.users
# }
