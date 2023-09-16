provider "aws" {
  region = "us-east-1"
}



module "vpc" {
   source    = "../module/vpc"
}



# module "ec2" {
#   source    = "../module/ec2"
#   linux     = "ami-06ca3ca175f37dd66"
#   inst_type = "t2.micro"
#   depends_on = [module.vpc]
# }


# module "elb" {
#   source    = "../module/elb"
#   public_subnets   = "${module.vpc.public_subnets}"
#   vpc_id    = "${module.vpc.vpc_id}"
#   target_id = "${module.ec2.target_id}"
# }



