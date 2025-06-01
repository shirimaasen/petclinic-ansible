resource "aws_key_pair" "lvm_migration_key" {
  key_name   = "${var.project_name}-key"
  public_key = file(var.public_key_path)
  
  tags = {
    Name        = "${var.project_name}-key"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_security_group" "lvm_migration_sg" {
  name        = "${var.project_name}-sg"
  description = "Security group for LVM migration and Spring PetClinic with Nginx"
  
  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidrs
    description = "SSH access"
  }
  
  # HTTP access (Nginx)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP access via Nginx"
  }
  
  # HTTPS access (Nginx)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS access via Nginx"
  }
  
  # Spring PetClinic direct access (for testing)
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidrs
    description = "Spring PetClinic direct access (restricted)"
  }
  
  # All outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outbound traffic"
  }
  
  tags = {
    Name        = "${var.project_name}-sg"
    Environment = var.environment
    Project     = var.project_name
  }
}
