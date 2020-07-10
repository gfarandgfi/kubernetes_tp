variable "tags" {
  description = "The tags for the resources that will be deployed"
  type = map(string)
}

variable "vpc_cidr_block" {}

variable "subnet_instances_cidr_block" {}

variable "subnet_clusters_a_cidr_block" {}

variable "subnet_clusters_b_cidr_block" {}

variable "aws_default_zone" {}

variable "student_names" {}

variable "cluster_name" {}