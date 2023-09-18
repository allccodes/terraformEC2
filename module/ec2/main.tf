

# # Data source to fetch de vpc ID
# data "aws_vpc" "example_vpc" {
#   id = "vpc-04beae6fe5e39cf1b"
# }

# # Data source to fetch the subnet ID
# data "aws_subnet" "example_subnet" {
#   vpc_id = "vpc-04beae6fe5e39cf1b"
#   cidr_block = "10.0.1.0/24"
#   #cidr_block = "10.0.0.0/24"
# }


# data "aws_instance" "example_instance" {
#   instance_id = "i-0e491f7aa4add9a37"
# }


# # Data source to fetch de vpc ID
# data "aws_vpc" "example_vpc" {
#   id = "vpc-04beae6fe5e39cf1b"
# }

# # Data source to fetch the PUBLIC subnets
# data "aws_subnets" "example" {
#   filter {
#     name   = "tag:Name"
#     values = ["*public*"]
#   }
# }


resource "aws_instance" "app" {
  #for_each      = toset(data.aws_subnets.example.ids)
  ami           = var.linux
  instance_type = var.inst_type
  #subnet_id     = each.value
  subnet_id = "vpc-0f90824179182398c"
  vpc_security_group_ids = [aws_security_group.public_instance_ssh.id, aws_security_group.public_instance_http.id]
  user_data = <<EOF
    #!/bin/bash
    sudo su
    yum update -y
    yum install -y httpd
    systemctl start httpd
  EOF 
  tags = {
    Name = "Public Server"
  }
}




# # CREATE INSTANCE

# resource "aws_instance" "myInstance" {
#   ami           = var.linux
#   instance_type = var.inst_type
#   subnet_id     = data.aws_subnet.example_subnet.id
  
#   vpc_security_group_ids = [aws_security_group.public_instance_ssh.id, aws_security_group.public_instance_http.id]
#   user_data              = <<EOF
#                             #!/bin/bash
#                             sudo su
#                             yum update -y
#                             yum install -y httpd
#                             systemctl start httpd
#                             EOF 
#   tags = {
#     Name = "Public Server"
#   }
# }


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


# # # # ALLOCATE AWS_EIP TO INSTANCE

resource "aws_eip" "demo-eip" {
  instance = data.aws_instance.example_instance.id
  domain = "vpc"
}



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