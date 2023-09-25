
# DATA SOURCE TO FETCH MY VPC

data "aws_vpc" "my_vpc" {
  filter {
    name = "tag:Name"
    values = [var.vpc_name]
  }
}




data "aws_subnet" "my_subnets" {
  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }
}





# CREATE INSTANCE

resource "aws_instance" "my_instance" {
  count         = var.instance_number
  ami           = var.ami_id
  instance_type = var.inst_type

  subnet_id     = data.aws_subnet.my_subnets.id[0]
  vpc_security_group_ids = [aws_security_group.public_instance_http.id]

  tags = {
    Name = "Public Server-${count.index}"
  }
}


# CREATE SECURITY GROUPS

resource "aws_security_group" "public_instance_http" {
  name        = "Public-instance-HTTP"
  description = "expose SSH and HTTP"
  vpc_id = data.aws_vpc.my_vpc.id
  

  ingress {
    protocol        = "tcp"
    from_port       = var.ingress1
    to_port         = var.ingress2
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




