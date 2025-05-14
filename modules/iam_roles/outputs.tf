output "node_role_arn" {
  description = "O ARN da IAM Role criada para o Node Group."
  value       = aws_iam_role.node_group_role.arn
}

output "node_role_name" {
  description = "O Nome da IAM Role criada para o Node Group."
  value       = aws_iam_role.node_group_role.name
}
