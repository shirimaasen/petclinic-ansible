resource "aws_instance" "lvm_migration_instance" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.lvm_migration_key.key_name
  vpc_security_group_ids = [aws_security_group.lvm_migration_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  availability_zone      = data.aws_availability_zones.available.names[0]
  
  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.root_volume_size
    delete_on_termination = true
    encrypted             = true
    
    tags = {
      Name        = "${var.project_name}-root-volume"
      Environment = var.environment
      Project     = var.project_name
    }
  }
  
  # User data script for initial setup
  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    hostname = "${var.project_name}-server"
  }))
  
  tags = {
    Name        = "${var.project_name}-instance"
    Environment = var.environment
    Project     = var.project_name
    Purpose     = "LVM Migration and Spring PetClinic with Nginx"
  }
}

resource "aws_eip" "lvm_migration_eip" {
  count            = var.use_elastic_ip ? 1 : 0
  instance         = aws_instance.lvm_migration_instance.id
  domain           = "vpc"
  
  tags = {
    Name        = "${var.project_name}-eip"
    Environment = var.environment
    Project     = var.project_name
  }
  
  depends_on = [aws_instance.lvm_migration_instance]
}
