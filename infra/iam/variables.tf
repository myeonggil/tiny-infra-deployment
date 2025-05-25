variable "users" {
  type = list(string)
  description = "Symaon developer"
}
variable "group_name" {
  type = list(string)
  default = [ "backend", "frontend" ]
}
variable "backend" {
  type = string
  default = "backend"
}
variable "frontend" {
  type = string
  default = "frontend"
}

locals {
  grouped_users = {
    for team in var.users : split("-", team)[0] => [
      for name in var.users : split("-", name)[1] if startswith(name, team)
    ]
  }
}
