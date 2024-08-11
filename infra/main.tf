provider "aws" {
  shared_config_files = [ "~/.aws/config" ]
  shared_credentials_files = [ "~/.aws/credentials" ]
  region = var.region
}


variable "region" {
  default = "ap-northeast-2"
  description = "deploy region"
}

variable "instance_type" {
  description = "compute"
}

variable "vpc_prefix" {
  description = "vpc prefix"
}

output "region" {
  value = var.region
}
