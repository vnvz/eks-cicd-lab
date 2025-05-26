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
      var.node_group_tags,
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

resource "kubernetes_config_map_v1_data" "aws_auth_patch" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
  force = true
  data = {
    "mapUsers" = yamlencode(distinct(concat(
      try(yamldecode(data.kubernetes_config_map.aws_auth.data["mapUsers"]), []),
      [
        {
          rolearn  = module.github_pipeline.pipeline_role_arn
          username = "github-actions-gh-actions-dp017"
          groups = ["system:masters"]
        }
      ]
    ))),

    "mapRoles" = yamlencode(distinct(concat(
      try(yamldecode(data.kubernetes_config_map.aws_auth.data["mapRoles"]), []),
      [
        {
          rolearn  = module.github_pipeline.pipeline_role_arn
          username = "github-actions-gh-actions-dp017"
          groups = [
            "system:masters"
          ]
        }
      ]
    )))
  }

  depends_on = [
    data.kubernetes_config_map.aws_auth,
    module.github_pipeline
  ]
}

  module "ecr" {
    source = "./modules/ecr"
    name   = "dp017-container-regrstry"
    tags   = var.node_group_tags
  }

  module "github_pipeline" {
    source     = "./modules/github_pipeline"
    name       = "gh-actions-dp017"
    repository = "vnvz/eks-cicd-lab"
    branch     = "master"
    tags       = var.node_group_tags
  }
