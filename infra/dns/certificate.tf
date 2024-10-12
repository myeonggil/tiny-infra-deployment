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
