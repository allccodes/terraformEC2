provider "aws" {
  region = "us-east-1"
}




# module "vpc" {
#    source    = "../module/vpc"
#    vpc_name = "myVPC"
# }


# module "ec2" {
#   source    = "../module/ec2"
#   instance_number = 1
#   subnet_id = "subnet-02507c6cb9e739f80"
#   vpc_name = "myVPC"
#   ingress2 = 80
#   depends_on = [module.vpc]
# }


# module "elb" {
#   source    = "../module/elb"
#   vpc_name = "myVPC"
#   depends_on = [module.vpc, module.ec2]
# }



