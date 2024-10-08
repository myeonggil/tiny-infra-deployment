provider "aws" {
  profile                  = "infra"
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  region                   = var.region
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
      version = "5.62.0"
    }
  }
}

module "service_deploy" {
  source       = "./network"
  vpc_cidr     = var.vpc_cidr
  service_name = var.service_name
  region       = var.region
  public_your_ip = "${chomp(data.http.icanhazip.response_body)}/32"
}

variable "service_name" {
  description = "service name"
}

variable "region" {
  default     = "ap-northeast-2"
  description = "deploy region"
}

variable "instance_type" {
  description = "compute"
}

variable "vpc_cidr" {
  description = "vpc cidr"
}

output "region" {
  value = var.region
}
