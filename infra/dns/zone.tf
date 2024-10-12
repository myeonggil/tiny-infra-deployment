resource "aws_route53_zone" "tiny_domain_zone" {
  name = var.domain_name
}