output "return_arns" {
    value = value(aws_s3_bucket_acl.example)[*].arn
}