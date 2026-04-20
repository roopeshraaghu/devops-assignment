output "public_ip" {
  value = aws_instance.this.public_ip
  description = "Public IP address of the EC2 instance"
}

output "public_dns" {
  value = aws_instance.this.public_dns
  description = "Public DNS of the EC2 instance"
}

output "instance_id" {
  value = aws_instance.this.id
  description = "EC2 instance ID"
}

output "private_ip" {
  value = aws_instance.this.private_ip
  description = "Private IP address of the EC2 instance"
}

output "security_group_id" {
  value = aws_security_group.this.id
  description = "Security group ID"
}

output "iam_role_name" {
  value = aws_iam_role.this.name
  description = "IAM role name attached to the EC2 instance"
}

output "cluster_name" {
  value = var.cluster_name
  description = "Name of the Kind cluster"
}