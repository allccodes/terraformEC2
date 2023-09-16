
# CREATE INSTANCE

# https://serverfault.com/questions/931609/terraform-how-to-reference-the-subnet-created-in-the-vpc-module

data "aws_vpc" "example_vpc" {
  id = "vpc-0982052aa15333394"
}

# Data source to fetch the subnet ID
data "aws_subnet" "example_subnet" {
  vpc_id = "vpc-0982052aa15333394"
}

resource "aws_instance" "myInstance" {
  ami           = var.linux
  instance_type = var.inst_type
  subnet_id     = data.aws_subnet.example_subnet.id
  # subnet_id = "${data.aws_subnet.myVPC.*.id}"
  
  vpc_security_group_ids = [aws_security_group.public_instance_ssh.id, aws_security_group.public_instance_http.id]
  user_data              = <<EOF
                            #!/bin/bash
                            yum update -y
                            yum install -y httpd
                            systemctl start httpd
                            EOF 
  tags = {
    Name = "Public Server"
  }
}


# CREATE SECURITY GROUPS

resource "aws_security_group" "public_instance_ssh" {
  name        = "Public-instance-SSH"
  description = "expose SSH"
  vpc_id = data.aws_vpc.example_vpc.id
  
  ingress {
    protocol        = "tcp"
    from_port       = 22
    to_port         = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "public_instance_http" {
  name        = "Public-instance-HTTP"
  description = "expose HTTP"
  vpc_id     = data.aws_vpc.example_vpc.id

  ingress {
    protocol        = "tcp"
    from_port       = 80
    to_port         = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# ALLOCATE AWS_EIP TO INSTANCE

# resource "aws_eip" "demo-eip" {
#   instance = aws_instance.myInstance.id
#   domain = "vpc"
# }



# CREATE DINAMO TABLE

# resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
#   name = "terraform-state-lock-dynamo"
#   hash_key = "LockID"
#   read_capacity = 5
#   write_capacity = 5
 
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }