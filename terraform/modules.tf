# Create an instance for each student
module "instances" {
  source              = "./modules/instances"
  aws_instance_type   = var.aws_instance_type
  aws_instance_ami    = var.aws_instance_ami
  aws_default_zone    = var.aws_default_zone
  subnet_id           = module.network.instances_subnet_id
  security_group_ids  = [module.network.security_group_ids]
  student_names       = var.student_names
}

module "clusters" {
  source                        = "./modules/clusters"
  aws_instance_type             = var.aws_instance_type
  role_arn                      = var.role_arn
  node_role_arn                 = var.node_role_arn
  security_group_ids = module.network.security_group_ids
  vpc_id                        = module.network.vpc_id
  clusters_subnet_id            = module.network.clusters_subnet_id
  subnet_id                     = module.network.clusters_subnet_id
  # private_subnets               = module.network.clusters_subnet_id
  tags                          = var.tags
  student_names                 = var.student_names
}

module "network" {
  source                      = "./modules/network"
  aws_default_zone            = var.aws_default_zone
  vpc_cidr_block              = "10.0.0.0/16"
  subnet_instances_cidr_block = "10.0.0.0/24"
  subnet_clusters_cidr_block  = "10.0.1.0/24"
  tags                        = var.tags
}
