output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.lvm_migration_instance.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = var.use_elastic_ip ? aws_eip.lvm_migration_eip[0].public_ip : aws_instance.lvm_migration_instance.public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.lvm_migration_instance.private_ip
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.lvm_migration_sg.id
}

output "lvm_volume_id" {
  description = "ID of the EBS volume for LVM"
  value       = aws_ebs_volume.lvm_volume.id
}

output "ssh_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh -i ~/.ssh/${var.project_name}-key ec2-user@${var.use_elastic_ip ? aws_eip.lvm_migration_eip[0].public_ip : aws_instance.lvm_migration_instance.public_ip}"
}

output "petclinic_url" {
  description = "URL to access Spring PetClinic via Nginx"
  value       = "http://${var.use_elastic_ip ? aws_eip.lvm_migration_eip[0].public_ip : aws_instance.lvm_migration_instance.public_ip}"
}

output "petclinic_direct_url" {
  description = "Direct URL to access Spring PetClinic (port 8080)"
  value       = "http://${var.use_elastic_ip ? aws_eip.lvm_migration_eip[0].public_ip : aws_instance.lvm_migration_instance.public_ip}:8080"
}

output "ansible_inventory" {
  description = "Ansible inventory configuration"
  value = {
    ansible_host                 = var.use_elastic_ip ? aws_eip.lvm_migration_eip[0].public_ip : aws_instance.lvm_migration_instance.public_ip
    ansible_user                 = "ec2-user"
    ansible_ssh_private_key_file = "~/.ssh/petclinic"
  }
}
