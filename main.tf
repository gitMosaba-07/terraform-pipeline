

resource "aws_vpc" "moses" {
  cidr_block       = "60.0.0.0/16"

  tags = {
    Name = "cicd-vpc"
  }
}

resource "aws_subnet" "pub" {
  vpc_id     = aws_vpc.moses.id
  cidr_block = "60.0.1.0/24"

  tags = {
    Name = "cicd-pub-subnet"
  }
}

resource "aws_subnet" "pri" {
  vpc_id     = aws_vpc.moses.id
  cidr_block = "60.0.2.0/24"

  tags = {
    Name = "cicd-pri-subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.moses.id

  tags = {
    Name = "cicd-igw"
  }
}

resource "aws_route_table" "rte" {
  vpc_id = aws_vpc.moses.id
   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
   tags = {
    Name = "cicd-rte"
  }
}

resource "aws_route_table_association" "asso" {
  subnet_id      = aws_subnet.pub.id
  route_table_id = aws_route_table.rte.id
}
