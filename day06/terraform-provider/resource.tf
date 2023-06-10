# create ec2 instance

resource "aws_instance" "practice" {
	ami = "ami-053b0d53c279acc90"
	instance_type = "t2.micro" # free tier
	security_groups = ["default"]
	key_name = "my-key-pair"
	tags = {
		Name = "PracticeInstance"
	}
}
