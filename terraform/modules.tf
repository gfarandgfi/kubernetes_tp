# Create an instance for each student
module "instances" {
  source              = "./modules/instances"
  subnet_id           = module.network.subnet_id
  aws_instance_type   = var.aws_instance_type
  aws_instance_ami    = var.aws_instance_ami
  aws_default_zone    = var.aws_default_zone
  security_group_ids  = [module.network.additional_security_group_ids]
  student_names       = var.student_names
}

module "clusters" {
  source                        = "./modules/clusters"
  additional_security_group_ids = module.network.additional_security_group_ids
  student_names                 = var.student_names
  tags                          = var.tags
  vpc_id                        = module.network.vpc_id
  private_subnets               = module.network.subnet_id
}

module "network" {
  source  = "./modules/network"
  tags    = var.tags
}

