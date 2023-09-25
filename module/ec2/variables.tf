variable "vpc_name" {
  type = string
  default = "myVPC"
}


variable "ami_id" {
  type    = string
  default = "ami-0ea75b80e2f0fc442"
}


variable "inst_type" {
  type    = string
  default = "t2.micro"
}


variable "instance_number" {
  type = number
}


variable "ingress1" {
  type = number
  default = 22
}

variable "ingress2" {
  type = number
}


variable "subnet_id" {
  type = string
}


variable "subnet_number" {
  type = number
  default = 0
}