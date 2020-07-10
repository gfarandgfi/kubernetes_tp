# The type of image that master machines will be deployed with. 
# "ami-09646e3744395249f" refers to an official Debian 10 Buster image
aws_instance_ami = "ami-09646e3744395249f"

# The region in which the resources will be deployed
# If you modify this, please make sure the ami and instance type are applicable for the new region
aws_default_region = "eu-west-3"

# The zone in which the resources will be deployed
# If you modify this, please make sure the ami and instance type are applicable for the new zone
aws_default_zone = "eu-west-3a"

# The type of instance that will be deployed
aws_instance_type = "t2.medium"

# The name of the students. Must be a map of strings.
# One cluster will be deployed per student_name
student_names = {
    teacher   = "gerard_farand"
    student_1 = "tariq_anoual" 
    student_2 = "ludovic_bels"
    student_3 = "loic_kervarec"
    student_4 = "florian_cambier"
}

# The tags that will be applied to all resources
tags = {
    Environment = "formation_kubernetes"
  }