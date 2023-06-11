# Setup public subnet
resource "aws_subnet" "public-subnets" {
  count      = length(var.cidr_public_subnet)
  vpc_id     = aws_vpc.custom-vpc.id
  cidr_block = element(var.cidr_public_subnet, count.index)
  availability_zone = element(var.eu_availability_zone, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "My-public-subnet ${count.index + 1}"
  }
}

# Setup private subnet
resource "aws_subnet" "private-subnets" {
  count      = length(var.cidr_private_subnet)
  vpc_id     = aws_vpc.custom-vpc.id
  cidr_block = element(var.cidr_private_subnet, count.index)
  availability_zone = element(var.eu_availability_zone, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "My-private-subnet ${count.index + 1}"
  }
}

