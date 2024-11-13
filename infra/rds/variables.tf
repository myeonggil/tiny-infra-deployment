variable "service_name" {}
variable "region" {}
variable "tiny_pub_subnet_ids" {}
variable "tiny_sg_ids" {}
variable "availability_zones" {
  description = "find availability_zones from region map"
}
