terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "ecr" {
  source = "./modules/ecr"

  repository_name = "simple-java-app"
  tags = {
    Environment = var.environment
    Project     = "DevOps-Final"
    ManagedBy   = "Terraform"
  }
}

module "ec2" {
  source = "./modules/ec2"

  cluster_name  = "devops-kind-cluster"
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Environment = var.environment
    Project     = "DevOps-Final"
    ManagedBy   = "Terraform"
  }
}

output "ecr_repository_url" {
  value       = module.ecr.repository_url
  description = "ECR repository URL"
}

output "ec2_public_ip" {
  value       = module.ec2.public_ip
  description = "EC2 instance public IP"
}

output "kind_cluster_name" {
  value       = "devops-kind-cluster"
  description = "Kind cluster name"
}