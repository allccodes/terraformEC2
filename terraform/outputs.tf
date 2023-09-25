
# OUTPUT LOAD BALANCER PUBLIC DNS

output "load_balancer_public_ip" {
  value = module.elb.load_balancer_public_ip
}