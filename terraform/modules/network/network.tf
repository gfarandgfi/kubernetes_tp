# # The following resources will create one vpc and two subnets (one for the clusters, and another for the master machines)

# Create independent vpc  and subnet for instances
resource "aws_vpc" "formation_kubernetes_instances" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = var.tags
}

resource "aws_internet_gateway" "formation_kubernetes_instances" {
  vpc_id = aws_vpc.formation_kubernetes_instances.id
  tags   = var.tags
}

resource "aws_subnet" "formation_kubernetes_instances" {
  vpc_id                  = aws_vpc.formation_kubernetes_instances.id
  cidr_block              = var.subnet_instances_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.aws_default_zone
  tags                    = var.tags
}

# Create separate vpc for clusters
# Start by listing available zones
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "formation_kubernetes" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = var.tags
}

resource "aws_internet_gateway" "formation_kubernetes" {
  vpc_id = aws_vpc.formation_kubernetes.id
  tags   = var.tags

  depends_on = [aws_vpc.formation_kubernetes]
}


resource "aws_subnet" "formation_kubernetes_clusters_a" {
  for_each                = var.student_names
  availability_zone       = data.aws_availability_zones.available.names[0]
  vpc_id                  = aws_vpc.formation_kubernetes.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 9, length(var.student_names))
  map_public_ip_on_launch = true
  tags                    = {
    Key   = [for student_names in aws_subnet.formation_kubernetes_clusters_a:"kubernetes.io/cluster/${student_names.name}"]
    Value = "shared"
  }
}

resource "aws_subnet" "formation_kubernetes_clusters_b" {
  for_each                = var.student_names
  availability_zone       = data.aws_availability_zones.available.names[1]
  vpc_id                  = aws_vpc.formation_kubernetes.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 9, length(var.student_names))
  map_public_ip_on_launch = true
  tags                    = {
    Key   = [for student_names in aws_subnet.formation_kubernetes_clusters_b:"kubernetes.io/cluster/${student_names.name}"]
    Value = "shared"
  }
}