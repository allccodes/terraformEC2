data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "primary" {
  availability_zone = data.aws_availability_zones.available.names[0]

}


