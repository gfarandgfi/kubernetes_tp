resource "aws_eks_cluster" "formation_kubernetes" {
  version  = "1.16"
  for_each = var.student_names
  name     = each.value
  role_arn = aws_iam_role.cluster_role.arn
  tags     = var.tags

  vpc_config {
    security_group_ids = [var.additional_security_group_ids]
    subnet_ids         = var.subnet_id
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  # depends_on = [
  #   aws_iam_role_policy_attachment.cluster_role-AmazonEKSClusterPolicy,
  #   aws_iam_role_policy_attachment.cluster_role-AmazonEKSServicePolicy,
  # ]
}

resource "aws_eks_node_group" "formation_kubernetes" {
  for_each        = var.student_names
  cluster_name    = each.value
  node_group_name = "node_group-${each.value}"
  node_role_arn   = aws_iam_role.cluster_role.arn
  subnet_ids      = var.subnet_id
  # Node configuration
  instance_types  = [var.aws_instance_type]
  labels          = var.tags

  remote_access {
    ec2_ssh_key = "formation_docker"
  }

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_eks_cluster.formation_kubernetes,
    aws_iam_role.cluster_role,
    # aws_iam_role_policy_attachment.cluster_role-AmazonEKSClusterPolicy,
    # aws_iam_role_policy_attachment.cluster_role-AmazonEKSServicePolicy,
  ]
}


resource "aws_iam_policy" "cluster_policy" {
  name        = "cluster_policy"
  path        = "/"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["*"],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

# IAM Role to allow EKS service to manage other AWS services
resource "aws_iam_role" "cluster_role" {
  name = "cluster_role"
  assume_role_policy = aws_iam_policy.cluster_policy.policy
  depends_on = [aws_iam_policy.cluster_policy]
}

# resource "aws_iam_role_policy_attachment" "cluster_role-AmazonEKSClusterPolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = aws_iam_role.cluster_role.name
# }

# resource "aws_iam_role_policy_attachment" "cluster_role-AmazonEKSServicePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
#   role       = aws_iam_role.cluster_role.name
# }

# module "eks" {
#   source       = "terraform-aws-modules/eks/aws"
#   student_names = var.student_names
#   for_each = var.student_names
#   cluster_name = each.value

#   subnets      = var.private_subnets

#   tags = var.tags

#   vpc_id = var.vpc_id

#   worker_groups = [
#     {
#       name                          = "worker-group-1"
#       instance_type                 = var.aws_instance_type
#       additional_userdata           = "formation_kubernetes"
#       asg_desired_capacity          = 1
#       additional_security_group_ids = [var.additional_security_group_ids]
#     },
#   ]
# }

# data "aws_eks_cluster" "cluster" {
#   name = module.eks.cluster_id
# }

# data "aws_eks_cluster_auth" "cluster" {
#   name = module.eks.cluster_id
# }
