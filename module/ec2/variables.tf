variable "linux" {
  type    = string
  default = "ami-06ca3ca175f37dd66"
}


variable "inst_type" {
  type    = string
  default = "t2.micro"
}


variable "instance_number" {
  type = number
}


variable "subnet_id" {

}