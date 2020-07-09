output "all_cluster_info" {
  value = module.clusters.all_public_info
}

output "all_instance_info" {
  value = module.instances.all_public_info
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.formation_kubernetes.certificate_authority.[*].data
}
