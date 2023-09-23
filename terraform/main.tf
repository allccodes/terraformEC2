provider "aws" {
  region = "us-east-1"
}




module "vpc" {
   source    = "../module/vpc"
}


# module "ec2" {
#   source    = "../module/ec2"
#   instance_number = 2
#   subnet_id = "subnet-014dd24cea4b30cf1"
#   depends_on = [module.vpc]
# }


# module "elb" {
#   source    = "../module/elb"
#   depends_on = [module.ec2]
# }



