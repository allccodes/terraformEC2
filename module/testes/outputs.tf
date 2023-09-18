output "subnet_ids" {
  value = data.aws_subnet.example.*.ids
}



