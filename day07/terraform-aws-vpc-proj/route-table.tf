resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.custom_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.custom_internet_gateway.id
  }
  tags = {
    Name = "public_route_table"
  }
}

resource "aws_route_table" "private_route_table" {
  count      = length(var.cidr_private_subnet)
  vpc_id = aws_vpc.custom_vpc.id
  depends_on = [aws_nat_gateway.custom_nat_gateway]
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.custom_nat_gateway[count.index].id
  }
  tags = {
    Name = "private_route_table"
  }
}
