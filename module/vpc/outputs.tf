# output "list_of_az" {
#   value = data.aws_availability_zones.available.names
# }


# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}
