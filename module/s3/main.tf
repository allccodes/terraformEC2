
resource "aws_s3_bucket" "secure_bucket" {
  bucket        = var.bucket_name
  force_destroy = false

  tags = {
    Name        = "secure-bucket"
    Environment = "Dev"
  }

}
