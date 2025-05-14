output "vpc_id" {
  description = "ID da VPC existente referenciada."
  value       = module.vpc.vpc_id
}

output "subnet_ids" {
  description = "IDs das subnets existentes referenciadas."
  value       = module.subnets.subnet_ids
}

output "cluster_security_group_id" {
  description = "ID do Security Group principal do cluster existente referenciado."
  value       = module.security_groups.cluster_security_group_id
}

output "eks_cluster_endpoint" {
  description = "Endpoint do cluster EKS existente referenciado."
  value       = module.eks_cluster.cluster_endpoint
  sensitive   = true
}

output "eks_cluster_name" {
  description = "Nome do cluster EKS existente referenciado."
  value       = module.eks_cluster.cluster_name
}

output "eks_cluster_oidc_issuer_url" {
  description = "URL do provedor OIDC do cluster EKS existente."
  value       = module.eks_cluster.cluster_oidc_issuer_url
}

output "app_load_balancer_url" {
  description = "URL para acessar a aplicação (via Load Balancer)."
  value = try(format("http://%s", module.my_app.service_load_balancer_hostname), "Load Balancer não pronto ou não criado.")
}

output "ecr_repository_url" {
  description = "ECR repo URL para push de imagens"
  value       = module.ecr.repository_url
}

output "pipeline_role_arn" {
  value = module.github_pipeline.pipeline_role_arn
}
