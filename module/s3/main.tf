resource "aws_s3_bucket_acl" "example" {
  bucket = var.bucket_name
  acl = "private"
}