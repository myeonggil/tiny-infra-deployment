locals {
  yaml_rg = yamldecode(file("${path.module}/config.yaml"))
}
