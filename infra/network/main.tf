# Internet Gateway
resource "aws_internet_gateway" "tiny_internetfacing" {
  vpc_id = aws_vpc.tiny_network.id
  tags = {
    Name = "tiny-internetfacing"
  }
}

# NAT
# resource "aws_eip" "public_ip" {}

resource "aws_nat_gateway" "tiny_private_connect" {
  allocation_id     = aws_eip.public_ip.id
  subnet_id         = aws_subnet.tiny_public_1.id
  connectivity_type = "private"
}

# Routing Table
resource "aws_route_table" "tiny_private" {
  vpc_id = aws_vpc.tiny_network.id
  tags = {
    Name = "tiny-private"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.tiny_private_connect.id
  }
}

resource "aws_route_table" "tiny_public" {
  vpc_id = aws_vpc.tiny_network.id
  tags = {
    Name = "tiny-public"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tiny_internetfacing.id
  }
}

resource "aws_route_table_association" "tiny_private_group_1" {
  subnet_id      = aws_subnet.tiny_private_1.id
  route_table_id = aws_route_table.tiny_private.id
}

resource "aws_route_table_association" "tiny_private_group_2" {
  subnet_id      = aws_subnet.tiny_private_2.id
  route_table_id = aws_route_table.tiny_private.id
}

resource "aws_route_table_association" "tiny_public_group_1" {
  subnet_id      = aws_subnet.tiny_public_1.id
  route_table_id = aws_route_table.tiny_public.id
}

resource "aws_route_table_association" "tiny_public_group_2" {
  subnet_id      = aws_subnet.tiny_public_2.id
  route_table_id = aws_route_table.tiny_public.id
}

# Security Group
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

resource "aws_vpc_security_group_ingress_rule" "allow_service_port" {
  security_group_id = aws_security_group.tiny_access_connection.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 8000
  ip_protocol = 8000
}

resource "aws_vpc_security_group_ingress_rule" "allow_postgresql" {
  security_group_id = aws_security_group.tiny_access_connection.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 5432
  ip_protocol = 5432
}

# Subnet Group
data "aws_availability_zones" "available" {}

variable "az_number" {
  # Assign a number to each AZ letter used in our configuration
  default = {
    a = 1
    b = 2
    c = 3
    d = 4
    e = 5
    f = 6
  }
}

resource "aws_subnet" "tiny_private_1" {
  vpc_id            = aws_vpc.tiny_network.id
  cidr_block        = cidrsubnet(aws_vpc.tiny_network.cidr_block, 2, 0)
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "tiny-private-1"
  }
}

resource "aws_subnet" "tiny_private_2" {
  vpc_id            = aws_vpc.tiny_network.id
  cidr_block        = cidrsubnet(aws_vpc.tiny_network.cidr_block, 2, 1)
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "tiny-private-2"
  }
}

resource "aws_subnet" "tiny_public_1" {
  vpc_id            = aws_vpc.tiny_network.id
  cidr_block        = cidrsubnet(aws_vpc.tiny_network.cidr_block, 2, 2)
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "tiny-public-1"
  }
}

resource "aws_subnet" "tiny_public_2" {
  vpc_id            = aws_vpc.tiny_network.id
  cidr_block        = cidrsubnet(aws_vpc.tiny_network.cidr_block, 2, 3)
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "tiny-public-2"
  }
}

# VPC
resource "aws_vpc" "tiny_network" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.service_name
  }
}
