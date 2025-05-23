variable "service_name" {
  description = "service name"
}
variable "domain_name" {
  description = "Already registered"
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

variable "users" {
  type = list(string)
  default = [ "mgju", "echosoul" ]
}