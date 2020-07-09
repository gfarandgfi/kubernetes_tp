#####################
##     main.tf     ##
#####################

# Welcome to the kubernetes training stack
# This stack deploys as many kubernetes clusters and master machines as you have students
# The clusters will run on an independent VPC and subnet, each called "formation_kubernetes"
# The clusters will be set with <cluster_name> = <student_name>
# The master machines will be set up with the tag Name = <student_name>
# The master machines will have public ips and public dns set up
# Authentication is via an ssh key. Create a new one by uncommenting the appropriate code (untested), 
# or provide your own in module/instances/instance.tf aws_instance.student.key_name
# Main values are set in terraform.tfvars

## TODO
## (master machines) install kubectl and git binaries
## (master machines) bind internet gateway to routing table
## (master machines) automatic install of generated kubeconfig
## (node groups) define role policy