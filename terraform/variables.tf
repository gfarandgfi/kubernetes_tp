variable "aws_default_region" {
  description = "The default in which the clusters will be created by default"
  type = string
}

variable "aws_instance_type" {
  description = "The type of instance that will be deployed as worker node"
  type = string
}

variable "student_names" {
  description = "the name of the students taking part in the training, in firstname_lastname format"
  type = map(string)
}

variable "tags" {
  description = "The tags for the resources that will be deployed"
  type = map(string)
}

variable "aws_instance_ami" {
  description = "The AMI for the OS. Defaults to Debian Buster"
  type        = string
}

variable "aws_default_zone" {
  description = "Default zone for the resources that will be deployed"
  type        = string
}

variable "role_arn" {}

variable "node_role_arn" {}

variable "subnet_tags" {}