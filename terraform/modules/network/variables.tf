variable "tags" {
  description = "The tags for the resources that will be deployed"
  type = map(string)
}

variable "subnet_cidr_block" {}

variable "aws_default_zone" {}

