# main.tf
resource "aws_instance" "my_instance_1" {
   ami = var.ami
   instance_type = var.instance_type
}
