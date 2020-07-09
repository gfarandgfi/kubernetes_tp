# The following resources will create the network infrastructure for the kubernetes clusters
# For the network infrastructure related to student ec2 instances, please see instances_network.tf

data "aws_availability_zones" "available" {}

resource "aws_vpc" "formation_kubernetes" {
  enable_dns_hostnames = true
  cidr_block           = "10.0.0.0/16"
  tags                 = var.tags
}

resource "aws_subnet" "formation_kubernetes" {
  vpc_id                  = aws_vpc.formation_kubernetes.id
  aws_availability_zones  = data.aws_availability_zones.available.names
  cidr_block              = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  for_each                = var.student_names
  tags                    = {
    kubernetes.io/cluster/${each.value} = "shared"
  }

  depends_on = [aws_vpc.formation_kubernetes]
}


# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "2.6.0"

#   name                 = "formation_kubernetes"
#   cidr                 = "10.0.0.0/16"
#   azs                  = data.aws_availability_zones.available.names
#   private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#   public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
#   enable_nat_gateway   = true
#   single_nat_gateway   = true
#   enable_dns_hostnames = true
#   for_each             = var.student_names
#   public_subnet_tags   = {
#     "kubernetes.io/cluster/${each.value}" = "shared"
#   }
#   private_subnet_tags  = {
#     "kubernetes.io/cluster/${each.value}" = "shared"
#   }
# }


