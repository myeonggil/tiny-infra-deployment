variable "users" {
  type = list(string)
  description = "Symaon developer"
}
variable "symaon_iam_group_name" {
  type = list(string)
  default = [ "backend", "frontend" ]
}
