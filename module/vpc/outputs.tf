# output "list_of_az" {
#   value = data.aws_availability_zones.available.names
# }

# output "vpc_id" {
#      value = module.vpc.vpc_id
# }


output "public_subnets" {
  value = module.vpc.public.*.id
}