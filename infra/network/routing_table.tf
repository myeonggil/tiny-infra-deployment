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