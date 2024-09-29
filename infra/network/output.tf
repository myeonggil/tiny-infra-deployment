output "vpc_id" {
  value = aws_vpc.tiny_network.id
}
output "tiny_sg_id" {
  value = aws_security_group.tiny_access_connection.id
}
output "tiny_subnet_group_id" {
  value = aws_subnet.tiny_public_1.id
}