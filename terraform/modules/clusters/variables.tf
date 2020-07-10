variable "student_names" {
  description = "the name of the students taking part in the training, in firstname_lastname format"
  type        = map(string)
}

variable "tags" {
  description = "The tags that will be applied to the resources"
  type = map(string)
}

variable "vpc_id" {
  description = "The VPC the clusters will be created on"
}

variable "security_group_ids" {
  description = "The IDs of the additional security groups"
}

variable "clusters_subnet_id" {
  description = "The subnets on which the clusters will be created"
}

variable "aws_instance_type" {}

variable "role_arn" {}

variable "node_role_arn" {}

variable "formation_kubernetes_clusters_subnet_a" {}

variable "formation_kubernetes_clusters_subnet_b" {}