
# CREATE INSTANCE

# https://serverfault.com/questions/931609/terraform-how-to-reference-the-subnet-created-in-the-vpc-module


# resource "aws_instance" "myInstance" {
#   ami           = var.linux
#   instance_type = var.inst_type
#   subnet_id = module.vpc.public_subnets[0]
#   vpc_security_group_ids = [aws_security_group.public_instance_ssh.id]
#   user_data              = <<EOF
#                             !/bin/bash
#                             yum update -y
#                             yum install apache2
#                             systemctl start httpd
#                             EOF 
#   tags = {
#     Name = "Public Server"
#   }
# }

# # https://stackoverflow.com/questions/75797258/how-do-i-reference-a-resource-created-from-different-module-in-my-current-module

resource "aws_security_group" "public_instance_ssh" {
  name        = "Public-instance"
  description = "expose SSH"
  # vpc_id      = module.vpc.vpc_id
  vpc_id = "${module.vpc.my_vpc_id}"

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


# resource "aws_security_group" "public_instance_80" {
#   name        = "Public-instance"
#   description = "expose HTTP"
#   vpc_id      = module.vpc.vpc_id
#   ingress {
#     protocol        = "tcp"
#     from_port       = 22
#     to_port         = 22
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

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 5
  write_capacity = 5
 
  attribute {
    name = "LockID"
    type = "S"
  }
}