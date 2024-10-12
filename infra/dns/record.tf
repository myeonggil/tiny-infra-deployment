resource "aws_route53_record" "tiny_host_record" {
  zone_id = aws_route53_zone.tiny_domain_zone.id
  name = "www.${var.domain_name}"
  type = "A"
  ttl = 300
  records = [ "" ]
}