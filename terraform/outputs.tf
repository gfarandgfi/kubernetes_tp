output "all_cluster_info" {
  value = module.clusters.all_public_info
}

output "all_instance_info" {
  value = module.instances.all_public_info
}

output "internet_gateway_id" {
  value = module.network.internet_gateway_id
}

