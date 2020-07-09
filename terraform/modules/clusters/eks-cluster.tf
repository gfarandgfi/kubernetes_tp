resource "aws_eks_cluster" "formation_kubernetes" {
  version  = "1.16"
  for_each = var.student_names
  name     = each.value
  # Hardcoded ARN. Should not be in a future version
  role_arn = var.role_arn
  tags     = var.tags

  vpc_config {
    security_group_ids = [var.additional_security_group_ids]
    subnet_ids         = var.subnet_id
  }
}

resource "aws_eks_node_group" "formation_kubernetes" {
  for_each        = var.student_names
  cluster_name    = each.value
  node_role_arn   = var.node_role_arn
  node_group_name = "node_group-${each.value}"
  # Hardcoded ARN. Should not be in a future version
  subnet_ids      = var.subnet_id
  # Node configuration
  instance_types  = [var.aws_instance_type]

  remote_access {
    ec2_ssh_key = "formation_docker"
  }

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [aws_eks_cluster.formation_kubernetes]
}


# resource "aws_iam_policy" "cluster_policy" {
#   name        = "cluster_policy"
#   path        = "/"
#   policy = file(./files/policy.json)
#   ]
# }
# EOF
# }

# # IAM Role to allow EKS service to manage other AWS services
# resource "aws_iam_role" "cluster_role" {
#   name = "cluster_role"
#   assume_role_policy = aws_iam_policy.cluster_policy.policy
#   depends_on = [aws_iam_policy.cluster_policy]
# }

# resource "aws_iam_role_policy_attachment" "cluster_role-AmazonEKSClusterPolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = aws_iam_role.cluster_role.name
# }

# resource "aws_iam_role_policy_attachment" "cluster_role-AmazonEKSServicePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
#   role       = aws_iam_role.cluster_role.name
# }