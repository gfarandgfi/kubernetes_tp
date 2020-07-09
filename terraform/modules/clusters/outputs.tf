output "all_public_info" {
  value = {
    for student_names in aws_eks_cluster.student:
      student_names.endpoint => student_names.certificate_authority
  }
}

output "node_status" {
  value = {
    for student_names in aws_eks_node_group.student:
      student_names.id => student_names.status
  }
}
