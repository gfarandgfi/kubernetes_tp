output "vpc_id" {
  value = aws_vpc.formation_kubernetes.id
}

output "security_group_ids" {
  value = aws_security_group.open_all.id
}

output "clusters_subnet_id" {
  value = aws_subnet.formation_kubernetes_clusters.id
}

output "instances_subnet_id" {
  value = aws_subnet.formation_kubernetes_instances.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.formation_kubernetes.id
}

