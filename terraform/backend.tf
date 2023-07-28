terraform {
  backend "s3" {
    bucket = "mybucketterra"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }

}