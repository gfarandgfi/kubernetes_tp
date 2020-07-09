output "vpc_id" {
  value = module.vpc.vpc_id
}

output "additional_security_group_ids" {
  value = aws_security_group.open_all.id
}

output "cluster_subnet_id" {
  value = module.vpc.private_subnets
}

output "instances_subnet_id" {
  value = aws_subnet.formation_kubernetes.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.formation_kubernetes.id
}

