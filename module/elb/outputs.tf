
# OUTPUT LOAD BALANCER PUBLIC DNS

output "load_balancer_public_ip" {
  value = aws_elb.alb.dns_name
}