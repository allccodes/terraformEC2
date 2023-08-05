# PROVIDER

provider "aws" {
  region = "us-east-1"
}




# CREATE INSTANCE

resource "aws_instance" "myInstance" {


   ami           = var.linux
   instance_type = "t2.micro"

  }