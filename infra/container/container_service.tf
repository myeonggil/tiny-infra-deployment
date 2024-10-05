resource "aws_ecs_service" "tiny_container_service" {
  name = "tiny-container-service"
  cluster = aws_ecs_cluster.tiny_container_cluster.id
  task_definition = aws_ecs_task_definition.tiny_task_definition.arn
  desired_count = 2
  launch_type = "FARGATE"
  force_new_deployment = true

  network_configuration {
    security_groups = [ var.tiny_sg_id ]
    subnets = var.tiny_subnet_groups_id
    assign_public_ip = false
  }

  # load_balancer {
  #   target_group_arn = ""
  #   container_name = ""
  #   container_port = ""
  # }

  # depends_on = [ 

  # ]

  tags = {
    Name = "tiny-containe-service"
  }
}