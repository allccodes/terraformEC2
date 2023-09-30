terraform {
  backend "s3" {
    bucket = "mybucketterra"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    #dynamodb_table = "terraform-state-lock-dynamo"
  }
}