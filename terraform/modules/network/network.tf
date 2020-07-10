# # The following resources will create one vpc and two subnets (one for the clusters, and another for the master machines)

# Create independent vpc  and subnet for instances
resource "aws_vpc" "formation_kubernetes_instances" {
  enable_dns_hostnames = true
  cidr_block           = var.vpc_cidr_block
  tags                 = var.tags
}

resource "aws_internet_gateway" "formation_kubernetes_instances" {
  vpc_id = aws_vpc.formation_kubernetes_instances.id
  tags   = var.tags
}

resource "aws_subnet" "formation_kubernetes_instances" {
  vpc_id            = aws_vpc.formation_kubernetes_instances.id
  cidr_block        = var.subnet_instances_cidr_block
  availability_zone = var.aws_default_zone
  tags              = var.tags
}

# Create separate vpc for clusters
# Start by listing available zones
data "aws_availability_zones" "available" {
  state = "available"
}

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


resource "aws_subnet" "formation_kubernetes_clusters_a" {
  availability_zone = data.aws_availability_zones.available.names[0]
  vpc_id            = aws_vpc.formation_kubernetes.id
  cidr_block        = var.subnet_clusters_a_cidr_block
  tags              = {
    Name        = "formation_kubernetes"
    Environment = "formation_kubernetes"
    Key         = "kubernetes.io/cluster/${var.cluster_name}" 
    Value       = "shared"
  }
}

resource "aws_subnet" "formation_kubernetes_clusters_b" {
  availability_zone = data.aws_availability_zones.available.names[1]
  vpc_id            = aws_vpc.formation_kubernetes.id
  cidr_block        = var.subnet_clusters_b_cidr_block
  tags              = {
    Name        = "formation_kubernetes"
    Environment = "formation_kubernetes"
    Key         = "kubernetes.io/cluster/${var.cluster_name}" 
    Value       = "shared"
  }
}