resource "aws_internet_gateway" "tiny_internetfacing" {
  vpc_id = aws_vpc.tiny_network.id
  tags = {
    Name = "tiny-internetfacing"
  }
}