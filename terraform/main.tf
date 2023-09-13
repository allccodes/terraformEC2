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
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"
  #azs = data.aws_availability_zones.az_available.names
}

output "available_zones" {
  value = data.aws_availability_zones.available.names
}

data "aws_availability_zones" "az_available" {
  state = "available"
}
