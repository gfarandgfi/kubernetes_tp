output "vpc_id" {
  value = aws_vpc.formation_kubernetes.id
}

output "security_group_ids" {
  value = aws_security_group.open_all.id
}

output "instances_subnet_id" {
  value = aws_subnet.formation_kubernetes_instances.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.formation_kubernetes.id
}

output "formation_kubernetes_clusters_subnet_a" {
  value = { 
    for student_names in aws_subnet.formation_kubernetes_clusters_a:"${student_names.id}"
  }
}

output "formation_kubernetes_clusters_subnet_b" {
  value = { 
    for student_names in aws_subnet.formation_kubernetes_clusters_b:"${student_names.id}"
  }
}

output "formation_kubernetes_instances_vpc_id" {
  value = aws_vpc.formation_kubernetes_instances.id
}

output "formation_kubernetes_instances_subnet_id" {
  value = aws_subnet.formation_kubernetes_instances.id
}


