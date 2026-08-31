variable "vpc_cidr" {}
variable "vpc_name" {}
variable "cidr_public_subnet" {}
variable "cidr_private_subnet" {}
variable "availability_zones" {}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}


resource "aws_subnet" "public" {
  count             = length(var.cidr_public_subnet)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.cidr_public_subnet, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "floci-infra-public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.cidr_private_subnet)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.cidr_private_subnet, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "floci-infra-private-subnet-${count.index + 1}"
  }
}


resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "floci-infra-internet-gateway"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "floci-infra-public-route-table"
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.cidr_public_subnet)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "floci-infra-private-route-table"
  }

}


resource "aws_route_table_association" "private" {
  count = length(var.cidr_private_subnet)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id

}

output "vpc_id" {
  value = aws_vpc.main.id

}


output "public_subnet_id" {
  value = aws_subnet.public[*].id

}


output "private_subnet_id" {
  value = aws_subnet.private[*].id

}
