
# Create SG for ALB
resource "aws_security_group" "elb_sg" {
  name_prefix = "elb-sg-"
  description = "Security group for Elastic Load Balancer"
  vpc_id     = var.vpc_id


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
    subnets            = var.public_subnets
}

# Create ALB target group
resource "aws_lb_target_group" "alb_tg" {
    name     = "tf-example-lb-tg"
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc_id
}


# Create target group attachement

resource "aws_lb_target_group_attachment" "example" {
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = var.target_id
  port             = 80
}

