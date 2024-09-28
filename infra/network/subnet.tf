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