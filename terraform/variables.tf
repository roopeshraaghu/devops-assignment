# AWS Configuration
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

# Environment Configuration
variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

# EC2 Configuration
variable "instance_type" {
  description = "EC2 instance type for the Kind cluster"
  type        = string
  default     = "t3.medium"

  validation {
    condition     = contains(["t3.medium", "t3.large", "t2.medium", "t2.large"], var.instance_type)
    error_message = "Instance type must be t3.medium, t3.large, t2.medium, or t2.large."
  }
}

variable "key_name" {
  description = "Name of the AWS EC2 key pair for SSH access"
  type        = string
  default     = "devops"
  sensitive   = true
}

# Optional: VPC Configuration
variable "vpc_id" {
  description = "VPC ID to deploy resources (optional, uses default VPC if not specified)"
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "Subnet ID to deploy EC2 instance (optional, uses default subnet if not specified)"
  type        = string
  default     = null
}

# Tags
variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}