output "all_public_info" {
  value = {
    for student_names in module.eks.student:
      student_names.cluster_endpoint => student_names.kubeconfig
  }
}