module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  student_names = var.student_names
  for_each = var.student_names
  cluster_name = each.value

  subnets      = var.private_subnets

  tags = var.tags

  vpc_id = var.vpc_id

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = var.aws_instance_type
      additional_userdata           = "formation_kubernetes"
      asg_desired_capacity          = 1
      additional_security_group_ids = [var.additional_security_group_ids]
    },
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
