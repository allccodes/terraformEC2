variable "nginx" {
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


variable "subnet_id" {
  type = number
}