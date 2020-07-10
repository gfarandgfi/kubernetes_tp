output "all_endpoints" {
  value = module.clusters.all_endpoints
}

# Add the result of this to the certificate-authority-data section of the kubeconfig file for each cluster.
output "all_certificates" {
  value = module.clusters.all_certificates
}

output "all_instance_info" {
  value = module.instances.all_public_info
}

output "internet_gateway_id" {
  value = module.network.internet_gateway_id
}

