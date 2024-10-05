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