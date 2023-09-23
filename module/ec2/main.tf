
# DATA SOURCE TO FETCH MY VPC

data "aws_vpc" "myVPC" {
  filter {
    name = "tag:Name"
    values = ["myVPC"]
  }
}


# CREATE INSTANCE

resource "aws_instance" "myInstance" {
  count         = var.instance_number
  ami           = var.nginx
  instance_type = var.inst_type

  subnet_id     = var.subnet_id
  vpc_security_group_ids = [aws_security_group.public_instance_http.id]

  tags = {
    Name = "Public Server-${count.index}"
  }
}


# CREATE SECURITY GROUPS

resource "aws_security_group" "public_instance_http" {
  name        = "Public-instance-HTTP"
  description = "expose SSH and HTTP"
  vpc_id = data.aws_vpc.myVPC.id

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

# resource "aws_security_group" "public_instance_http" {
#   name        = "Public-instance-HTTP"
#   description = "expose HTTP"
#   vpc_id     = data.aws_vpc.myVPC.id

#   ingress {
#     protocol        = "tcp"
#     from_port       = 80
#     to_port         = 80
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     protocol    = "-1"
#     from_port   = 0
#     to_port     = 0
#     cidr_blocks = ["0.0.0.0/0"]
#   }
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