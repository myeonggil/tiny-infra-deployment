
# ECS Cluster
resource "aws_ecs_cluster" "tiny_container_cluster" {
  name = "tiny-container-cluster"

  setting {
    name = "containerInsights"
    value = "enabled"
  }
}

# Container Service
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

# Container Repository
resource "aws_ecr_repository" "tiny_container_image_repo" {
  name = "tiny-container-image-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# Container Task Definition
data "aws_iam_policy_document" "ecs_task_execution_role" {
  version = "2012-10-17"

  statement {
    sid = ""
    effect = "Allow"
    actions = [ "sts:AssumeRole" ]

    principals {
      type = "Service"
      identifiers = [ "ecs-tasks.amazonaws.com" ]
    }
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
}

resource "aws_iam_policy_attachment" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
  roles = [ aws_iam_role.ecs_task_execution_role.name ]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "tiny_task_definition" {
  family = "service"
  requires_compatibilities = ["FARGATE"]
  network_mode = "bridge"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
      name = "tiny"
      image = "nginx:latest"
      cpu = 256
      memory = 512
      enssential = true
      portMappings = [
        {
          containerPort = 80
          hostPort = 80
        }
      ]
    },
  ])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture = "X86_64"
  }
}
