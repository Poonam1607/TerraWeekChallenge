data "aws_subnet" "public_subnet" {
  filter {
    name = "tag:Name"
    values = ["Subnet-Public : Public Subnet 1"]
  }

  depends_on = [
    aws_route_table_association.public_subnet_asso
  ]
}

resource "aws_instance" "my_web_instances" {
  ami = "ami-0767046d1677be5a0"
  instance_type = "t2.micro"
  tags = {
    Name = "EC2 Public subnet 1"
  }
  key_name= "my-key-pair"
  subnet_id = data.aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.Custom_Public_SG_DB.id]
  user_data = <<-EOF
        #!/bin/bash
        yum update -y
        yum install httpd -y
        systemctl start httpd
        systemctl enable httpd
        echo "<html><body><h1>This is My Custom Project Tier 1 </h1></body></html>" > /var/www/html/index.html
        EOF
}

resource "aws_key_pair" "deployer" {
  key_name   = "my-key-pair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCe0PKAuH5M/vMTdXPpvoYO+TThkoHHFKqZapwFtLoxDLZSFPeJ3iO6VTXWKd4QiQip8d1BKHiVgwAMGsm+X65Aaq3GN3QRxsXp0BaNqeAZBwsJJamqVYObXrFxGTPHvroC107LIWek5Mishnbrl2cW/rvoEZsUi5Yq4w6nkboAwz3+9GVbnjzc8TkpA4Az2pLOtBMclMcBKBLzfnNoqVERnlfNb1FchscMj/xthE0bgJkiqX/o1hVGGOmWFzr6lVQlfuwwG75dFZwAHzSyaYimmPeWeur0e4a7iotIU1DuMpEfWH8IUfKGhw7V2ThvD/VF/AVQ0tmnCJTOPyea0S+H"
}


output "fetched_info_from_aws" {
  value = format("%s%s","ssh -i /Users/poonampawar/Downloads/my-key-pair ubuntu@",aws_instance.my_web_instances.public_dns)
}
