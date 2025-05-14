output "pipeline_role_arn" {
  description = "ARN da Role para GitHub Actions"
  value       = aws_iam_role.github_pipeline.arn
}
