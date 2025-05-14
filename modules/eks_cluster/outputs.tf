output "cluster_arn" {
  description = "ARN do cluster EKS."
  value       = data.aws_eks_cluster.selected.arn
}

output "cluster_endpoint" {
  description = "Endpoint do servidor da API Kubernetes do cluster EKS."
  value       = data.aws_eks_cluster.selected.endpoint
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "Dados do certificado da CA (codificado em base64) para o cluster."
  value       = data.aws_eks_cluster.selected.certificate_authority[0].data
  sensitive   = true
}

output "cluster_version" {
  description = "Versão do Kubernetes do cluster EKS."
  value       = data.aws_eks_cluster.selected.version
}

output "cluster_oidc_issuer_url" {
  description = "URL do provedor OIDC do cluster (para IAM Roles for Service Accounts)."
  value = data.aws_eks_cluster.selected.identity[0].oidc[0].issuer
}

output "cluster_auth_token" {
  description = "Token de autenticação temporário para o cluster (útil para o provider Kubernetes)."
  value       = data.aws_eks_cluster_auth.selected.token
  sensitive   = true
}

output "cluster_name" {
  description = "Nome do cluster EKS."
  value       = data.aws_eks_cluster.selected.name
}
