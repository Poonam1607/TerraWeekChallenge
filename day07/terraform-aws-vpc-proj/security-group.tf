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

#creating public security group
resource "aws_security_group" "Custom-Public-SG-DB" {
  name        = "Custom-Public-SG-DB"
  description = "web and SSH allowed"
  vpc_id      = aws_vpc.custom-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
ec2.tf
In the ec2.tf file, the code provided below creates two EC2 instances of type t2.micro. The user_data code included in the configuration installs and initiates the Apache web server on each EC2 instance. Additionally, it generates a basic custom webpage to be hosted by the web server.


COPY
#creating EC2 instance
resource "aws_instance" "My-web-instance1" {
  ami                         = "ami-02f3f602d23f1659d" #Amazon linux 2 AMI
  key_name                    = "mykeypair"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public-subnet1.id
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.Custom-Public-SG-DB.id]
  user_data                   = <<-EOF
        #!/bin/bash
        yum update -y
        yum install httpd -y
        systemctl start httpd
        systemctl enable httpd
        echo "<html><body><h1>This is My Custom Project Tier 1 </h1></body></html>" > /var/www/html/index.html
        EOF
}

#creating EC2 instance
resource "aws_instance" "My-web-instance2" {
  ami                         = "ami-02f3f602d23f1659d" #Amazon linux 2 AMI 
  key_name                    = "mykeypair"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public-subnet2.id
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.Custom-Public-SG-DB.id]
  user_data                   = <<-EOF
        #!/bin/bash
        yum update -y
        yum install httpd -y
        systemctl start httpd
        systemctl enable httpd
        echo "<html><body><h1>This is My Custom Project Tier 2 </h1></body></html>" > /var/www/html/index.html
        EOF
}
rds.tf
In this section, we will construct our database code, specifically for a single RDS MySQL instance. Please copy the code provided below. If you require guidance on building this code, you can visit the Terraform Registry, which offers assistance in constructing each section of the code.


COPY
#creating RDS Database
resource "aws_db_instance" "My_database" {
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  db_subnet_group_name   = aws_db_subnet_group.My-Custom-subgroup.id
  vpc_security_group_ids = [aws_security_group.Custom-Public-SG-DB.id]
  username               = "username" 
  password               = "password" 
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true

}

#creating private security group for Database tier
resource "aws_security_group" "My_database_tier_lu" {
  name        = "My_database_tier_lu"
  description = "allow traffic from SSH & HTTP"
  vpc_id      = aws_vpc.custom-vpc.id

  ingress {
    from_port       = 8279 #default port is 3306. You can also use 3307 & 8279 like myself
    to_port         = 8279
    protocol        = "tcp"
    cidr_blocks     = ["10.0.0.0/16"]
    security_groups = [aws_security_group.My-sg.id]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

#creating public security group
resource "aws_security_group" "Custom_Public_SG_DB" {
  name        = "Custom-Public-SG-DB"
  description = "web and SSH allowed"
  vpc_id      = aws_vpc.custom_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
