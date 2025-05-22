# Certificate
resource "aws_acm_certificate" "tiny_certificate" {
  domain_name = var.domain_name
  subject_alternative_names = [ "*.${var.domain_name}" ]
  validation_method = "DNS"

  tags = {
    Environment = "tiny"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Route53 Record
resource "aws_route53_record" "tiny_host_record" {
  zone_id = aws_route53_zone.tiny_domain_zone.id
  name = "www.${var.domain_name}"
  type = "CNAME"
  ttl = 300
  records = [ var.tiny_lb.dns_name ]

  depends_on = [ var.tiny_lb ]
}

# Zone
resource "aws_route53_zone" "tiny_domain_zone" {
  name = var.domain_name
}
