
# OUTPUT LOAD BALANCER PUBLIC DNS

output "load_balancer_public_ip" {
  value = aws_lb.alb.load_balancer_dns_name
}