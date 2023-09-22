
# Data source to fetch the PUBLIC SUBNETS
data "aws_subnets" "mySubnets" {
  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }
}

# Data source to fetch my VPC
data "aws_vpc" "myVPC" {
  filter {
    name = "tag:Name"
    values = ["myVPC"]
  }
}

# Data source to fetch my RUNNING INSTANCES
data "aws_instances" "running_instances" {
  instance_state_names = ["running"]
}



# Create SG for ALB
resource "aws_security_group" "elb_sg" {
  name_prefix = "elb-sg-"
  description = "Security group for Elastic Load Balancer"
  vpc_id = data.aws_vpc.myVPC.id

  ingress {
    protocol        = "tcp"
    from_port       = 80
    to_port         = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}



# Create ALB
resource "aws_lb" "alb" {
    name               = "test-alb-tf"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.elb_sg.id]
    subnets = data.aws_subnets.mySubnets.ids
    
}

# Create ALB target group
resource "aws_lb_target_group" "alb_tg" {
    name     = "tf-example-lb-tg"
    port     = 80
    protocol = "HTTP"
    vpc_id = data.aws_vpc.myVPC.id

    health_check {
      matcher = "200,301,302"
      path    = "/"
      interval = 120
      timeout = 30
  }
}


# Create target group attachment
  resource "aws_lb_target_group_attachment" "example" {
    for_each         = toset(data.aws_instances.running_instances.ids)
    target_group_arn = aws_lb_target_group.alb_tg.arn
    target_id        = each.value
    port             = 80
}



#  Create ALB listener
resource "aws_lb_listener" "test-http-listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    forward {
      target_group {
        arn    = aws_lb_target_group.alb_tg.arn
        weight = 250
      }
    }
  }
}



