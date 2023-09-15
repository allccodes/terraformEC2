# output "vpc_id" {
#     value = module.vpc.vpc_id
# }


# output "subnet_id" {
#   value = module.vpc.subnet_id
# }


output "public_subnets" {
  value = module.vpc.public_subnets[*]
}