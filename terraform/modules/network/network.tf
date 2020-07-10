# # The following resources will create one vpc and two subnets (one for the clusters, and another for the master machines)

resource "aws_vpc" "formation_kubernetes" {
  enable_dns_hostnames = true
  cidr_block           = var.vpc_cidr_block
  tags                 = var.tags
}

resource "aws_internet_gateway" "formation_kubernetes" {
  vpc_id = aws_vpc.formation_kubernetes.id
  tags   = var.tags

  depends_on = [aws_vpc.formation_kubernetes]
}

resource "aws_subnet" "formation_kubernetes_instances" {
  vpc_id            = aws_vpc.formation_kubernetes.id
  cidr_block        = var.subnet_instances_cidr_block
  availability_zone = var.aws_default_zone
  tags              = var.tags

  depends_on = [aws_vpc.formation_kubernetes]
}

resource "aws_subnet" "formation_kubernetes_clusters" {
  vpc_id            = aws_vpc.formation_kubernetes.id
  cidr_block        = var.subnet_clusters_cidr_block
  availability_zone = var.aws_default_zone
  tags              = var.tags

  depends_on = [aws_vpc.formation_kubernetes]
}

