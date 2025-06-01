resource "aws_cloudwatch_log_group" "application_logs" {
  name              = "/aws/ec2/${var.project_name}"
  retention_in_days = var.log_retention_days
  
  tags = {
    Name        = "${var.project_name}-logs"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_cloudwatch_log_group" "nginx_logs" {
  name              = "/aws/ec2/${var.project_name}/nginx"
  retention_in_days = var.log_retention_days
  
  tags = {
    Name        = "${var.project_name}-nginx-logs"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_cloudwatch_log_group" "petclinic_logs" {
  name              = "/aws/ec2/${var.project_name}/petclinic"
  retention_in_days = var.log_retention_days
  
  tags = {
    Name        = "${var.project_name}-petclinic-logs"
    Environment = var.environment
    Project     = var.project_name
  }
}
