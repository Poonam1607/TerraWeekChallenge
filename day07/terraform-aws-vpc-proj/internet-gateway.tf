resource "aws_internet_gateway" "custom-internet-gateway" {
  vpc_id = aws_vpc.custom-vpc.id
  tags = {
    Name = "My-Internet-Gateway"
  }
}
