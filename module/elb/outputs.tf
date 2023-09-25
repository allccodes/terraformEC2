
# OUTPUT LOAD BALANCER PUBLIC DNS

output "elb_public_ip" {
  value = aws_elb.alb.dns_name
}