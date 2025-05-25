module "vpc" {
  source = "./modules/vpc"
  vpc_id = var.existing_vpc_id
}

module "subnets" {
  source     = "./modules/subnets"
  subnet_ids = var.existing_subnet_ids
}

module "security_groups" {
  source        = "./modules/security_groups"
  cluster_sg_id = var.existing_cluster_sg_id
}

module "eks_cluster" {
  source       = "./modules/eks_cluster"
  cluster_name = var.existing_eks_cluster_name
}

module "eks_node_group" {
  source = "./modules/node_group"

  cluster_name  = module.eks_cluster.cluster_name
  node_role_arn = module.node_group_iam_role.node_role_arn
  subnet_ids    = module.subnets.subnet_ids

  node_group_name        = var.node_group_name
  instance_types         = var.node_group_instance_types
  scaling_min_size       = var.node_group_scaling_min
  scaling_max_size       = var.node_group_scaling_max
  scaling_desired_size   = var.node_group_scaling_desired
  tags                   = var.node_group_tags

  depends_on = [
    module.eks_cluster,
    module.subnets,
    module.node_group_iam_role
  ]
}

module "node_group_iam_role" {
  source = "./modules/iam_roles"
  tags = merge(
    var.node_group_tags, # <--- Já passa as tags definidas na variável
    { Name = "eks-nodegroup-role-${var.existing_eks_cluster_name}" }
  )
  cluster_name = module.eks_cluster.cluster_name
}

module "my_app" {
  source = "./modules/k8s_app"
  app_name = "vvv-pcgbf-app"
  app_image = "vnvzz/getting-started"
  labels = {
    "Periodo" = var.node_group_tags["Periodo"]
    "Aluno"   = var.node_group_tags["Aluno"]
  }

  depends_on = [
    module.eks_node_group
  ]
}

data "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
  depends_on = [module.eks_cluster]
}

module "ecr" {
  source = "./modules/ecr"
  name   = "dp017-container-regrstry"       # ou outro nome que preferir
  tags   = var.node_group_tags     # você já tem node_group_tags definidas
}

module "github_pipeline" {
  source     = "./modules/github_pipeline"
  name       = "github-actions-eks-pipeline-role"
  repository = "vnvz/eks-cicd-lab"  # ajuste para seu repo
  branch     = "master"
  tags       = var.node_group_tags
}
