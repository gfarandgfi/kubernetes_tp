# Create an instance for each student
module "instances" {
  source              = "./modules/instances"
  aws_instance_type   = var.aws_instance_type
  aws_instance_ami    = var.aws_instance_ami
  aws_default_zone    = var.aws_default_zone
  subnet_id           = module.network.instances_subnet_id
  security_group_ids  = [module.network.additional_security_group_ids]
  student_names       = var.student_names
}

module "clusters" {
  source                        = "./modules/clusters"
  aws_instance_type             = var.aws_instance_type
  role_arn                      = var.role_arn
  node_role_arn                 = var.node_role_arn
  additional_security_group_ids = module.network.additional_security_group_ids
  vpc_id                        = module.network.vpc_id
  subnet_id                     = module.network.cluster_subnet_id
  private_subnets               = module.network.cluster_subnet_id
  tags                          = var.tags
  student_names                 = var.student_names
}

module "network" {
  source            = "./modules/network"
  aws_default_zone  = var.aws_default_zone
  subnet_cidr_block = "10.0.0.0/24"
  subnet_tags       = var.subnet_tags
}