locals {
  main-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.formation_kubernetes.endpoint}' --b64-cluster-ca '${aws_eks_cluster.formation_kubernetes.certificate_authority.0.data}' '${var.cluster-name}'
USERDATA
}