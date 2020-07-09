# The region in which the instances will be deployed
# If you modify this, please make sure the ami and instance type are applicable for the new region
aws_default_region = "eu-west-3"

# The type of instance that will be deployed
aws_instance_type = "t2.medium"

k8s_master_version = ">=1.16"

# The name of the students. Must be a map of strings.
# One cluster will be deployed per student_name
student_names = {
    student_1 = "tariq_anoual" 
    student_2 = "ludovic_bels"
    student_3 = "loic_kervarec"
    student_4 = "florian_cambier"
}

tags = {
    Environment = "formation_kubernetes"
  }