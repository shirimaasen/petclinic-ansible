resource "aws_ebs_volume" "lvm_volume" {
  availability_zone = aws_instance.lvm_migration_instance.availability_zone
  size              = var.lvm_volume_size
  type              = "gp3"
  encrypted         = true
  iops              = var.lvm_volume_iops
  throughput        = var.lvm_volume_throughput
  
  tags = {
    Name        = "${var.project_name}-lvm-volume"
    Environment = var.environment
    Project     = var.project_name
    Purpose     = "LVM for /var migration"
  }
}

# Attach EBS Volume to EC2
resource "aws_volume_attachment" "lvm_attachment" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.lvm_volume.id
  instance_id = aws_instance.lvm_migration_instance.id
  
  # Force detachment on destroy
  force_detach = true
  skip_destroy = false
}
