# modules/k8s_app/outputs.tf

output "deployment_name" {
  description = "Nome do Deployment Kubernetes criado."
  value       = kubernetes_deployment.app.metadata[0].name
}

output "service_name" {
  description = "Nome do Service Kubernetes criado."
  value       = kubernetes_service.app.metadata[0].name
}

output "service_load_balancer_hostname" {
  description = "Hostname do Load Balancer (se aplicável)."
  value = try(kubernetes_service.app.status[0].load_balancer[0].ingress[0].hostname, null)
}

output "service_cluster_ip" {
  description = "IP interno do cluster para o Service (se aplicável)."
  value       = kubernetes_service.app.spec[0].cluster_ip
}
