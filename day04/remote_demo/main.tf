provider "aws" {
	region = "us-east-1"
}

resource "aws_instance" "my_ec2_instance" {
	count = 3
	ami = "ami-04a0ae173da5807d3"
	instance_type = "t2.micro"
	tags = {
	Name = "terraweek-instance"
}
}
