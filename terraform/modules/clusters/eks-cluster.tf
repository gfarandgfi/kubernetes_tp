# Create the clusters 
resource "aws_eks_cluster" "formation_kubernetes" {
  version  = "1.16"
  for_each = var.student_names
  name     = each.value
  role_arn = aws_iam_role.eks.arn
  tags     = var.tags

  vpc_config {
    security_group_ids      = [var.security_group_ids]
    subnet_ids              = var.clusters_subnet_id
    endpoint_private_access = true
    endpoint_public_access  = false
  }
  depends_on = [
    aws_iam_role_policy_attachment.main-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.main-cluster-AmazonEKSServicePolicy,
  ]
}

# Fetch an ami for the nodes
data "aws_ami" "eks-worker" {
  filter {
    for_each = var.student_names
    name     = "name"
    values   = [for student_names in aws_eks_cluster.formation_kubernetes:"amazon-eks-node-${student_names.version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI Account ID
}

resource "aws_eks_node_group" "formation_kubernetes" {
  for_each        = var.student_names
  cluster_name    = each.value
  node_group_name = "main_node_group-${each.value}"
  node_role_arn   = aws_iam_role.main-node.arn
  subnet_ids      = [var.clusters_subnet_id]
  # Node configuration
  instance_types  = [var.aws_instance_type]

  remote_access {
  # Hardcoded ssh key. Should be generated in a future version
    ec2_ssh_key = "formation_docker"
  }

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [
    aws_eks_cluster.formation_kubernetes,
    aws_iam_role_policy_attachment.main-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.main-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.main-node-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.main-node-AmazonEC2FullAccess,
    ]
}
