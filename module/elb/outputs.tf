output "running_instances" {
    value = [for instance in data.aws_instances.running_instances.ids : instance]
}