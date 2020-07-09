output "all_public_info" {
  value = {
    for student_names in aws_instance.student:
      student_names.tags => student_names.public_ip
  }
}