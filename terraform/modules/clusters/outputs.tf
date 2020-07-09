output "all_public_info" {
  value = {
    for student_names in aws_eks_cluster.formation_kubernetes:
      student_names.endpoint => student_names.certificate_authority
  }
}

output "node_status" {
  value = {
    for student_names in aws_eks_node_group.formation_kubernetes:
      student_names.id => student_names.status
  }
}

output "cluster names" {
  value = {
    for student_names in aws_eks_cluster.formation_kubernetes:student_names.name
  }
}
