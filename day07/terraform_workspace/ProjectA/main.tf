# main.tf
resource "aws_instance" "projectA" {
    ami = lookup(var.ami, terraform.workspace)
    instance_type = var.instance_type
    tags = {
        Name = terraform.workspace
    }
}
