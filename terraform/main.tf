 module "ec2" {
    source    = "../module/ec2"
    linux     = "ami-06ca3ca175f37dd66"
    inst_type = "t2.micro"
}

 provider "aws" {
   region = "us-east-1"
}
