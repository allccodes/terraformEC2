module "ec2" {
   source    = "../module/ec2"
   linux     = "ami-06ca3ca175f37dd66"
   inst_type = "t2.micro"
}

 provider "aws" {
   region = "us-east-1"
}


# Colocado para importar
# resource "aws_instance" "console" {
#   ami           = "ami-051f7e7f6c2f40dc1"
#   instance_type = "t2.micro"
# }


# Colocado para importar
# provider "aws" {
#   region = "us-east-1"
# }
