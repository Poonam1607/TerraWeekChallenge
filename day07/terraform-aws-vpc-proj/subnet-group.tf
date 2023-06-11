#creating subnet group
resource "aws_db_subnet_group" "My-Custom-subgroup" {
  name       = "my-custom-subgroup"
  subnet_ids = [aws_subnet.private-subnet1.id, aws_subnet.private-subnet2.id]
  tags = {
    Name = "My data base subnet group"
  }
}
