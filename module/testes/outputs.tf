output "subnet_ids" {
  value = data.aws_subnets.example.*.ids
}