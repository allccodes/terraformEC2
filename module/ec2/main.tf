# PROVIDER

provider "aws" {
  region = "us-east-1"
}




# CREATE INSTANCE

resource "aws_instance" "myInstance" {


   ami           = var.linux
   instance_type = "t2.micro"

  }



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