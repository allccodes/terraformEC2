
resource "aws_s3_bucket" "myBucket" {
  bucket        = var.bucket_name
  force_destroy = false

  tags = {
    Name        = "secure-bucket"
    Environment = "Dev"
  }

}
