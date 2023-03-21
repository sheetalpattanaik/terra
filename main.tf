#this file consists of code for instances and sg
provider "aws" {
region = "us-east-1"
access_key = "AKIAYWPX5IFWZIGD3UGI"
secret_key = "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"
}

resource "aws_instance" "one" {
  ami             = "ami-02f3f602d23f1659d"
  instance_type   = "t2.micro"
  key_name        = "ansible"
  vpc_security_group_ids = [aws_security_group.three.id]
  availability_zone = "us-east-1a"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my app created by terraform infrastructurte by raham sir server-1" > /var/www/html/index.html
EOF
  tags = {
    Name = "server-1"
  }
}

resource "aws_instance" "two" {
  ami             = "ami-02f3f602d23f1659d"
  instance_type   = "t2.micro"
  key_name        = "ansible"
  vpc_security_group_ids = [aws_security_group.three.id]
  availability_zone = "us-east-1b"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my website created by terraform infrastructurte by sheetal" > /var/www/html/index.html
EOF
  tags = {
    Name = "server-2"
  }
}

resource "aws_security_group" "three" {
  name = "elb-sg"
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

resource "aws_s3_bucket" "four" {
  bucket = "sheetal0077bucketterra"
}

resource "aws_iam_user" "five" {
name = "sheetal11" 
}

resource "aws_ebs_volume" "six" {
 availability_zone = "us-east-1b"
  size = 40
  tags = {
    Name = "ebs-001"
  }
}
