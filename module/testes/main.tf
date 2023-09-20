# Data source to fetch de vpc ID
# data "aws_vpc" "example_vpc" {
#   id = "vpc-0f90824179182398c"
# }

# Data source to fetch the PUBLIC subnets
data "aws_subnets" "example" {
  filter {
    name   = "tag:Name"
    values = ["*Default*"]
  }
}



# CREATE INSTANCE

resource "aws_instance" "app" {
  count = length(data.aws_subnets.example)
  #for_each      = toset(data.aws_subnets.example.ids)
  ami           = var.linux
  instance_type = var.inst_type
  subnet_id = "${data.aws_subnets.example[count.index]}"
  #subnet_id     = each.value
  #vpc_security_group_ids = [aws_security_group.public_instance_ssh.id, aws_security_group.public_instance_http.id]
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF
  tags = {
    Name = "Public Server"
  }
}





# # CREATE INSTANCE

# resource "aws_instance" "app" {
#   count = length(data.aws_subnets.example)
#   #for_each      = toset(data.aws_subnets.example.ids)
#   ami           = var.linux
#   instance_type = var.inst_type
#   subnet_id = data.aws_subnets.example[count.index]
#   #subnet_id     = each.value
#   vpc_security_group_ids = [aws_security_group.public_instance_ssh.id, aws_security_group.public_instance_http.id]
#   user_data = <<-EOF
#               #!/bin/bash
#               yum update -y
#               yum install -y httpd
#               systemctl start httpd
#               systemctl enable httpd
#               EOF
#   tags = {
#     Name = "Public Server"
#   }
# }
