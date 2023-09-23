provider "aws" {
  region = "us-east-1"
}




module "vpc" {
   source    = "../module/vpc"
}


module "ec2" {
  source    = "../module/ec2"
  instance_number = 1
  subnet_id = "subnet-02507c6cb9e739f80"
  ingress2 = 80
  depends_on = [module.vpc]
}


module "elb" {
  source    = "../module/elb"
  depends_on = [module.ec2]
}



