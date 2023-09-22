output "running_instances" {
    value = module.elb.aws_instances.running_instances.ids
}