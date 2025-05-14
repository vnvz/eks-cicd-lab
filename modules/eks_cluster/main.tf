data "aws_eks_cluster" "selected" {
  name = var.cluster_name
}

# Data source para obter informações de autenticação (útil depois)
data "aws_eks_cluster_auth" "selected" {
  name = var.cluster_name
}
