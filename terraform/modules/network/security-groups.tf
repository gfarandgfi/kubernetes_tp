resource "aws_security_group" "open_all" {
  name        = "open_all"
  description = "allow all traffic in and out"
  vpc_id      = aws_vpc.formation_kubernetes.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

