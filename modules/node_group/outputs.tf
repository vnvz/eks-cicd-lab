output "node_group_id" {
  description = "O ID do EKS Managed Node Group."
  value       = aws_eks_node_group.this.id
}

output "node_group_arn" {
  description = "O ARN do EKS Managed Node Group."
  value       = aws_eks_node_group.this.arn
}

output "node_group_resources" {
  description = "Recursos associados ao Node Group (como ASG, Launch Template ID)."
  value       = aws_eks_node_group.this.resources
  sensitive   = true
}

output "node_group_status" {
  description = "O status atual do Node Group."
  value       = aws_eks_node_group.this.status
}

output "node_group_version" {
  description = "A versão do AMI/Kubernetes do Node Group."
  value       = aws_eks_node_group.this.version
}
