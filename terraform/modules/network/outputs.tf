output "vpc_id" {
  value = module.vpc.vpc_id
}

output "additional_security_group_ids" {
  value = aws_security_group.open_all.id
}

output "subnet_id" {
  value = module.vpc.private_subnets
}