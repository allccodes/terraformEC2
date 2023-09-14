# output "list_of_az" {
#   value = data.aws_availability_zones.available.names
# }

output "public_subnets" {
  value = aws_subnet.public.*.id
}

