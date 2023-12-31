
# DATA SOURCE TO FETCH MY VPC

data "aws_vpc" "my_vpc" {
  filter {
    name = "tag:Name"
    values = [var.vpc_name]
  }
}


# DATA SOURCE TO FETCH THE PUBLIC SUBNETS

data "aws_subnets" "public_subnets" {
  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }
}


# DATA SOURCE TO FETCH THE PRIVATE SUBNETS

data "aws_subnets" "private_subnets" {
  filter {
    name   = "tag:Name"
    values = ["*private*"]
  }
}


# SUBNET NUMBER

locals {
  subnet_number = var.subnet_number 
}



# CREATE PUBLIC INSTANCE

resource "aws_instance" "my_instance_public" {
  count = var.subnet_type == "public" ? var.instance_number : 0
  ami           = var.ami_id
  instance_type = var.inst_type


  subnet_id = length(data.aws_subnets.public_subnets.ids) > 0 ? element(data.aws_subnets.public_subnets.ids, local.subnet_number) : null
  vpc_security_group_ids = [aws_security_group.public_instance_http.id]

  tags = {
    Name = "Public Server-${count.index}"
  }
}


# CREATE PRIVATE INSTANCE

resource "aws_instance" "my_instance_private" {
  count = var.subnet_type == "private" ? var.instance_number : 0
  ami           = var.ami_id
  instance_type = var.inst_type


  subnet_id = length(data.aws_subnets.private_subnets.ids) > 0 ? element(data.aws_subnets.private_subnets.ids, local.subnet_number) : null
  vpc_security_group_ids = [aws_security_group.private_instance_ssh.id]

  tags = {
    Name = "Private Server-${count.index}"
  }
}


# CREATE PUBLIC SECURITY GROUPS

resource "aws_security_group" "public_instance_http" {
  name        = "Public-instance-HTTP"
  description = "expose SSH and HTTP"
  vpc_id = data.aws_vpc.my_vpc.id
  

  ingress {
    protocol        = "tcp"
    from_port       = var.ingress1
    to_port         = var.ingress1
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol        = "tcp"
    from_port       = var.ingress2
    to_port         = var.ingress2
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# CREATE PRIVATE SECURITY GROUPS

resource "aws_security_group" "private_instance_ssh" {
  # count = var.subnet_type == "private" ? 1 : 0
  name        = "Private-instance-SSH"
  description = "expose SSH"
  vpc_id = data.aws_vpc.my_vpc.id
  

  ingress {
    protocol        = "tcp"
    from_port       = var.ingress1
    to_port         = var.ingress1
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# https://dilani-alwis.medium.com/terraform-tips-tricks-de8bc46dde13