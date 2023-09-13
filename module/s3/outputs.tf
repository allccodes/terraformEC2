output "return_arn" {
     value = "${aws_s3_bucket.myBucket.id}"
}


output "vpc_id" {
     value = aws_vpc.name.id
}