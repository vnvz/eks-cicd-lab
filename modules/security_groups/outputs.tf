output "cluster_security_group_id" {
  description = "O ID do Security Group principal do cluster selecionado."
  value       = data.aws_security_group.cluster_sg.id
}