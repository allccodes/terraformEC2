output "target_id" {
    value = aws_instance.myInstance.id
}

output "subnet_id" {
  value = data.aws_subnet.example_subnet.id
}