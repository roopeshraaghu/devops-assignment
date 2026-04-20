# Cluster Configuration
variable "cluster_name" {
  description = "Name of the Kind cluster"
  type        = string
  default     = "devops-kind-cluster"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.cluster_name))
    error_message = "Cluster name must contain only lowercase letters, numbers, and hyphens."
  }
}

# EC2 Configuration
variable "instance_type" {
  description = "EC2 instance type for the Kind cluster"
  type        = string
  default     = "t3.medium"

  validation {
    condition     = contains(["t2.medium", "t2.large", "t3.medium", "t3.large", "t4g.medium", "t4g.large"], var.instance_type)
    error_message = "Instance type must be t2.medium, t2.large, t3.medium, t3.large, t4g.medium, or t4g.large."
  }
}

variable "key_name" {
  description = "Name of the AWS EC2 key pair for SSH access"
  type        = string
  sensitive   = true
}

# Network Configuration
variable "vpc_id" {
  description = "VPC ID to deploy the EC2 instance (optional, uses default VPC if not specified)"
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "Subnet ID to deploy EC2 instance (optional, uses default subnet if not specified)"
  type        = string
  default     = null
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP address to the EC2 instance"
  type        = bool
  default     = true
}

# Security Group Configuration
variable "allowed_ssh_cidrs" {
  description = "CIDR blocks allowed to SSH into the EC2 instance"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "allowed_http_cidrs" {
  description = "CIDR blocks allowed to access HTTP (port 80)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "allowed_https_cidrs" {
  description = "CIDR blocks allowed to access HTTPS (port 443)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "allowed_nodeport_cidrs" {
  description = "CIDR blocks allowed to access NodePort range (30000-30001)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "nodeport_start" {
  description = "Starting port for NodePort range"
  type        = number
  default     = 30000
}

variable "nodeport_end" {
  description = "Ending port for NodePort range"
  type        = number
  default     = 30001
}

# ECR Access Configuration
variable "ecr_repositories" {
  description = "List of ECR repositories that the EC2 instance should have access to"
  type        = list(string)
  default     = ["*"]  # Allow access to all ECR repositories
}

# User Data Configuration
variable "user_data_script" {
  description = "Custom user data script to run on instance launch (overrides default)"
  type        = string
  default     = null
}

variable "enable_docker" {
  description = "Whether to install Docker on the EC2 instance"
  type        = bool
  default     = true
}

variable "enable_kind" {
  description = "Whether to install Kind on the EC2 instance"
  type        = bool
  default     = true
}

variable "enable_kubectl" {
  description = "Whether to install kubectl on the EC2 instance"
  type        = bool
  default     = true
}

variable "enable_helm" {
  description = "Whether to install Helm on the EC2 instance"
  type        = bool
  default     = true
}

variable "kind_version" {
  description = "Version of Kind to install"
  type        = string
  default     = "v0.20.0"
}

variable "helm_version" {
  description = "Version of Helm to install"
  type        = string
  default     = "v3.12.0"
}

# Additional Features
variable "enable_metrics_server" {
  description = "Whether to install Metrics Server on the Kind cluster"
  type        = bool
  default     = true
}

variable "enable_ingress_nginx" {
  description = "Whether to install NGINX Ingress Controller on the Kind cluster"
  type        = bool
  default     = true
}

variable "enable_cert_manager" {
  description = "Whether to install cert-manager on the Kind cluster"
  type        = bool
  default     = false
}

# Storage Configuration
variable "root_volume_size" {
  description = "Size of the root EBS volume in GB"
  type        = number
  default     = 30
}

variable "root_volume_type" {
  description = "Type of the root EBS volume"
  type        = string
  default     = "gp3"

  validation {
    condition     = contains(["gp2", "gp3", "io1", "io2", "st1", "sc1"], var.root_volume_type)
    error_message = "Volume type must be gp2, gp3, io1, io2, st1, or sc1."
  }
}

variable "additional_volumes" {
  description = "Additional EBS volumes to attach to the EC2 instance"
  type = list(object({
    size        = number
    type        = string
    device_name = string
  }))
  default = []
}

# Monitoring and Logging
variable "enable_detailed_monitoring" {
  description = "Whether to enable detailed monitoring for the EC2 instance"
  type        = bool
  default     = false
}

# IAM Configuration
variable "iam_role_name" {
  description = "Name of the IAM role for EC2 (overrides default)"
  type        = string
  default     = null
}

variable "iam_policy_name" {
  description = "Name of the IAM policy for ECR access (overrides default)"
  type        = string
  default     = null
}

variable "additional_iam_policies" {
  description = "List of additional IAM policy ARNs to attach to the EC2 role"
  type        = list(string)
  default     = []
}

# Lifecycle and Maintenance
variable "enable_termination_protection" {
  description = "Whether to enable termination protection on the EC2 instance"
  type        = bool
  default     = false
}

variable "instance_tenancy" {
  description = "Tenancy of the EC2 instance"
  type        = string
  default     = "default"

  validation {
    condition     = contains(["default", "dedicated", "host"], var.instance_tenancy)
    error_message = "Instance tenancy must be default, dedicated, or host."
  }
}

# Tags
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Terraform   = "true"
    Provisioned = "true"
  }
}

# Backup and Recovery
variable "enable_auto_backup" {
  description = "Whether to enable automated backups"
  type        = bool
  default     = false
}

variable "backup_retention_days" {
  description = "Number of days to retain backups"
  type        = number
  default     = 7
}

# Advanced Configuration
variable "user_data_variables" {
  description = "Additional variables to pass to the user_data script"
  type        = map(string)
  default     = {}
}

variable "extra_security_group_rules" {
  description = "Additional security group rules to add"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = []
}