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
