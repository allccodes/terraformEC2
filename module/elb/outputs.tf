
# OUTPUT LOAD BALANCER PUBLIC DNS

output "elb_public_ip" {
  value = aws_lb.alb.dns_name
}