# Provision a Debian 10 Buster machine 
resource "aws_instance" "student" {
  for_each                  = var.student_names
  tags                      = {
    Name = "${each.value}"
  }
  ami                         = var.aws_instance_ami
  instance_type               = var.aws_instance_type
  availability_zone           = var.aws_default_zone
  subnet_id                   = var.subnet_id
  key_name                    = "formation_docker"
  vpc_security_group_ids      = var.security_group_ids
  # associate_public_ip_address = true
}