output "all_endpoints" {
  value = {
    for student_names in aws_eks_cluster.formation_kubernetes:
      student_names.name => student_names.endpoint
  }
}

# Add the result of this to the certificate-authority-data section of the kubeconfig file for each cluster.
output "all_certificates" {
  value = {
    for student_names in aws_eks_cluster.formation_kubernetes:
      student_names.name => student_names.certificate_authority
  }
}

output "node_status" {
  value = {
    for student_names in aws_eks_node_group.formation_kubernetes:
      student_names.id => student_names.status
  }
}

output "role_arn" {
  value = aws_iam_role.eks.arn
}

output "node_role_arn" {
  value = aws_iam_role.main-node.arn
}

output "cluster_name" {
  value = [for student_names in  aws_eks_cluster.formation_kubernetes:"${student_names.name}"]
}