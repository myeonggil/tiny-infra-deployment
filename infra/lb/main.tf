# Loadbalancer
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

# Target Group
resource "aws_lb_target_group" "tiny_lb_tg" {
  name = "tiny-lb-tg"
  port = 8000
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = "ip" # ecs

  health_check {
    port = 8000
    protocol = "HTTP"
    path = "/docs"
  }

  tags = {
    Name = "tiny-lb-tg"
  }
}

resource "aws_lb_target_group_attachment" "tiny_lb_tga" {
  target_group_arn = aws_lb_target_group.tiny_lb_tg.arn
  target_id = var.service_id
  port = 8000
}

