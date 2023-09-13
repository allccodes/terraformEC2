module "ec2" {
  source    = "../module/ec2"
  linux     = "ami-06ca3ca175f37dd66"
  inst_type = "t2.micro"
}

provider "aws" {
  region = "us-east-1"
}


 module "s3" {
    source    = "../module/s3"
    bucket_name = "novobucket001"
}




# https://cs.fyi/guide/renaming-things-in-terraform
# https://hackernoon.com/change-the-name-of-an-aws-s3-bucket-in-terraform-without-breaking-things



# https://www.bitslovers.com/terraform-data/



module "vpc" {
   source  = "../module/vpc"
   aws_region = "us-east-1"
   #azs = data.aws_availability_zones.az_available.names
}

output "list_of_az" {
  value = module.vpc.list_of_az
}




