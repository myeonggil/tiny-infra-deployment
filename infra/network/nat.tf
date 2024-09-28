resource "aws_eip" "public_ip" {}

resource "aws_nat_gateway" "tiny_private_connect" {
  allocation_id     = aws_eip.public_ip.id
  subnet_id         = aws_subnet.tiny_public_1.id
  connectivity_type = "private"
}