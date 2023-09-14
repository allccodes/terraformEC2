provider "aws" {
  region = "us-east-1"
}



# module "vpc" {
#   source    = "../module/vpc"
# }


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

 
  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}


output "vpc_id" {
     value = module.vpc.vpc_id
}






module "ec2" {
  source    = "../module/ec2"
  depends_on = [module.vpc]
  linux     = "ami-06ca3ca175f37dd66"
  inst_type = "t2.micro"
}


# module "s3" {
#   source    = "../module/s3"
#   bucket_name = "novobucket001"
# }




# https://cs.fyi/guide/renaming-things-in-terraform
# https://hackernoon.com/change-the-name-of-an-aws-s3-bucket-in-terraform-without-breaking-things
# https://www.bitslovers.com/terraform-data/


# Exemplo de ouput a partir de um modulo
# Em main.tf do modulo fica o data
# Em outputs.tf do modulo columas por exe: value = data.aws_availability_zones.available.names


# module "vpc" {
#    source  = "../module/vpc"
#    aws_region = "us-east-1"
#    #azs = data.aws_availability_zones.az_available.names
# }

# output "list_of_az" {
#   value = module.vpc.list_of_az
# }






