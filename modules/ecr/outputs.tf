output "repository_url" {
  description = "URL completa do repositório ECR"
  value       = aws_ecr_repository.this.repository_url
}
