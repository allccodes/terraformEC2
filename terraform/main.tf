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
    bucket_name = "mybuckettreas01"
}




# https://cs.fyi/guide/renaming-things-in-terraform