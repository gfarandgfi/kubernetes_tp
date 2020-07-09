resource "aws_subnet" "formation_kubernetes" {
  vpc_id            = module.vpc.vpc_id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.aws_default_zone
  tags              = var.network_tags

  depends_on = [module.vpc]
}

resource "aws_internet_gateway" "formation_kubernetes" {
  vpc_id = module.vpc.vpc_id
  tags   = var.tags

  depends_on = [aws_subnet.formation_kubernetes]
}