resource "aws_lb" "tiny_lb" {
  name = "tiny-lb"
  internal = false
  load_balancer_type = "application"
  security_groups = [var.tiny_tg_sg]
  subnets = [for subnet in var.tiny_subnet_pub_ids : subnet]

  enable_deletion_protection = true

  tags = {
    Name = "tiny-lb"
  }
}

resource "aws_lb_listener" "tiny_lbl" {
  load_balancer_arn = aws_lb.tiny_lb.arn
  port = "443"
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.certification

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tiny_lb_tg.arn
  }
}
