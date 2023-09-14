

# Create ALB
resource "aws_lb" "alb" {
    name               = "test-alb-tf"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.lb_sg.id]
    subnets            = aws_subnet.public.*.id
}

# Create ALB target group
resource "aws_lb_target_group" "alb_tg" {
    name     = "tf-example-lb-tg"
    port     = 80
    protocol = "HTTP"
    vpc_id   = aws_vpc.main.id
}

# Create NLB
resource "aws_lb" "nlb" {
    name               = "test-nlb-tf"
    internal           = false
    load_balancer_type = "network"
    subnets            = aws_subnet.public.*.id
}

# Create NLB target group that forwards traffic to alb
# https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_CreateTargetGroup.html
resource "aws_lb_target_group" "nlb_tg" {
    name         = "tf-example-nlb-tg"
    port         = 80
    protocol     = "TCP"
    vpc_id       = aws_vpc.main.id
    target_type  = "alb"
}

# Create target group attachment
# More details: https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_TargetDescription.html
# https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_RegisterTargets.html
resource "aws_lb_target_group_attachment" "tg_attachment" {
    target_group_arn = aws_lb_target_group.nlb_tg.arn
    # attach the ALB to this target group
    target_id        = aws_lb.alb.arn
    #  If the target type is alb, the targeted Application Load Balancer must have at least one listener whose port matches the target group port.
    port             = 80
}
