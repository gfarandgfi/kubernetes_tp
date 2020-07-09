variable "student_names" {
  description = "the name of the students taking part in the training, in firstname_name format"
  type        = map(string)
}

variable "tags" {
  description = "The tags that will be applied to the resources"
  type = map(string)
}

variable "vpc_id" {
  description = "The VPC the clusters will be created on"
}

variable "additional_security_group_ids" {
  description = "The IDs of the additional security groups"
}

variable "private_subnets" {
  description = "The subnets on which the clusters will be created"
}

variable "subnet_id" {}

variable "aws_instance_type" {}

variable "role_arn" {}

variable "node_role_arn" {}