variable "aws_default_region" {
  description = "The default in which the clusters will be created by default"
  type = string
}

variable "aws_instance_type" {
  descritpion = "The type of instance that will be deployed as worker node"
  type = string
}

variable "student_names" {
  description = "the name of the students taking part in the training, in firstname_lastname format"
  type = map(string)
}

tags = {
    Environment = "formation_kubernetes"
  }