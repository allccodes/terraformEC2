# output "list_of_az" {
#   value = data.aws_availability_zones.available.names
# }

output "vpc_id" {
  value = module.vpc.vpc_id
}


output "subnet_id" {
  value = module.vpc.public_subnets[0]
}