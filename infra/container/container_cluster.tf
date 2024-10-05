resource "aws_ecs_cluster" "tiny_container_cluster" {
  name = "tiny-container-cluster"

  setting {
    name = "containerInsights"
    value = "enabled"
  }
}