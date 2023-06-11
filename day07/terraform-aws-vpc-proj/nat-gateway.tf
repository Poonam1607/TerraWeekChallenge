resource "aws_eip" "custom-elastic-ip" {
  count = length(var.cidr_private_subnet)
  vpc = true
}

resource "aws_nat_gateway" "custom-nat-gateway" {
  count      = length(var.cidr_private_subnet)
  depends_on = [aws_eip.nat_eip]
  allocation_id = aws_eip.custom-elastic.id
  subnet_id = aws_subnet.aws_jhooq_private_subnets[count.index].id
  tags = {
    "Name" = "Private NAT GW: For Jhooq EU Central Project "
  }
}
