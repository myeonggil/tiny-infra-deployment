resource "aws_ecr_repository" "tiny_container_image_repo" {
  name = "tiny-container-image-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
