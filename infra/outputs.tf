output "region" {
  value = var.region
}

output "dns_name" {
  value = module.dns.certification
}
