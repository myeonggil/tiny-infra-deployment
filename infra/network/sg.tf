resource "aws_security_group" "tiny_api_service" {
  vpc_id = aws_vpc.tiny_network.id

  tags = {
    Name = "tiny-api-service"
  }
  depends_on = [ aws_vpc.tiny_network ]
}

resource "aws_security_group" "tiny_access_connection" {
  vpc_id = aws_vpc.tiny_network.id

  tags = {
    Name = "tiny-access-connection"
  }
  depends_on = [ aws_vpc.tiny_network ]
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.tiny_api_service.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  ip_protocol = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.tiny_api_service.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 443
  ip_protocol = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.tiny_access_connection.id
  cidr_ipv4 = var.public_your_ip
  from_port = 22
  ip_protocol = 22
}