output "vpc_id" {
  value = aws_vpc.tiny_network.id
}
output "tiny_sg_id" {
  value = aws_security_group.tiny_access_connection.id
}
output "tiny_subnet_group_id" {
  value = aws_subnet.tiny_public_1.id
}
output "tiny_nginx_sg_id" {
  value = aws_security_group.tiny_api_service.id
}
output "tiny_ecs_subnet_groups" {
  value = [aws_subnet.tiny_private_1.id, aws_subnet.tiny_private_2.id]
}