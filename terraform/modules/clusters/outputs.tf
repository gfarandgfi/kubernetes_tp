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