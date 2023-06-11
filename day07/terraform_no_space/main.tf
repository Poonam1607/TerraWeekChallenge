# create a simple configuration file that creates an EC2 instance in AWS having no workspace
resource "aws_instance" "projectA" {
    ami = "ami-0edab43b6fa892279"
    instance_type = "t2.micro"
    tags = {
        Name = "ProjectA"
    }
}
