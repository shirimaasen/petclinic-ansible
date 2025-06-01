variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "eu-north-1"
}

variable "project_name" {
  description = "Name of the project (used for resource naming)"
  type        = string
  default     = "lvm-petclinic"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}

variable "root_volume_size" {
  description = "Size of root EBS volume in GB"
  type        = number
  default     = 20
}

variable "lvm_volume_size" {
  description = "Size of additional EBS volume for LVM in GB"
  type        = number
  default     = 10
}

variable "lvm_volume_iops" {
  description = "IOPS for LVM EBS volume (GP3)"
  type        = number
  default     = 3000
}

variable "lvm_volume_throughput" {
  description = "Throughput for LVM EBS volume in MB/s (GP3)"
  type        = number
  default     = 125
}

variable "public_key_path" {
  description = "Path to SSH public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "allowed_ssh_cidrs" {
  description = "CIDR blocks allowed for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "use_elastic_ip" {
  description = "Whether to create and assign an Elastic IP"
  type        = bool
  default     = true
}

variable "log_retention_days" {
  description = "CloudWatch logs retention period in days"
  type        = number
  default     = 14
}
