provider "aws" {
  region = "us-east-1"
}




module "vpc" {
   source    = "../module/vpc"
}


module "ec2" {
  source    = "../module/ec2"
  instance_number = 1
  vpc_id = "vpc-0027b709979b1392e"
  subnet_id = "subnet-05f9de789de5841b9"
  linux     = "ami-06ca3ca175f37dd66"
  inst_type = "t2.micro"
  depends_on = [module.vpc]
}


# module "elb" {
#   source    = "../module/elb"
#   vpc_id = "vpc-0027b709979b1392e"
#   depends_on = [module.vpc]
# }



