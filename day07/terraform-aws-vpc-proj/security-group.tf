resource "aws_security_group" "My-sg" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress                = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = "0"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = "0"
    }
  ]
  vpc_id = aws_vpc.custom_vpc.id
  depends_on = [aws_vpc.custom_vpc]
  description = "security group for load balancer"
  tags = {
    Name = "My-sg"
  }
}
