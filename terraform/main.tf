provider "aws" {
  region = "us-east-1"
}




module "vpc" {
   source    = "../module/vpc"
}


module "ec2" {
  source    = "../module/ec2"
  instance_number = 1 
  linux     = "ami-06ca3ca175f37dd66"
  inst_type = "t2.micro"
  subnet_id = "subnet-010aa024febe40ee8"
  depends_on = [module.vpc]
}


# module "elb" {
#   source    = "../module/elb"
#   vpc_id = "vpc-0027b709979b1392e"
#   depends_on = [module.vpc]
# }



