output "region" {
  value = local.yaml_rg["resource_groups"]["rg-01"]["location"]
}
output "test" {
  value = local.yaml_rg
}
