output "return_arns" {
    value = values(aws_s3_bucket.example)[*].arn
}