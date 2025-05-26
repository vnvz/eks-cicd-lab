locals {
  common_labels = merge(
    {
      app = var.app_name # Label principal para seleção
    },
    var.labels
  )
}

resource "kubernetes_deployment" "app" {
  metadata {
    name      = var.app_name
    namespace = var.namespace
    labels    = local.common_labels
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = local.common_labels
    }

    template {
      metadata {
        labels = local.common_labels
      }

      spec {
        container {
          name  = var.app_name
          image = var.app_image

          port {
            container_port = var.container_port
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "app" {
  metadata {
    name      = var.app_name
    namespace = var.namespace
    labels    = local.common_labels
  }

  spec {
    selector = local.common_labels

    port {
      port        = var.service_port
      target_port = var.container_port
      protocol    = "TCP"
    }

    type = var.service_type
  }
}
