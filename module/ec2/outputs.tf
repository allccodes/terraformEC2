# output "target_id" {
#     value = aws_instance.myInstance.id
# }


# output "list_of_az" {
#   value = data.aws_availability_zones.available.names
# }


data "aws_vpc" "example_vpc" {
  id = "vpc-0982052aa15333394"
}

output "vpc_id" {
  value = data.aws_vpc.example_vpc.id
}


# Data source to fetch the subnet ID
data "aws_subnet" "example_subnet" {
  vpc_id = "vpc-0982052aa15333394"
  cidr_block = "10.0.1.0/24"
}

out_put "subnet_id" {
    value = data.aws_subnet.example_subnet.vpc_id
}