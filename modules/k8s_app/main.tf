locals {
  common_labels = merge(
    {
      app = var.app_name # Label principal para seleção
    },
    var.labels # Mescla com quaisquer labels extras passadas
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
      match_labels = local.common_labels # Seleciona pods com estas labels
    }

    template {
      metadata {
        labels = local.common_labels # Aplica labels aos pods
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
      port        = var.service_port     # Porta externa do serviço
      target_port = var.container_port # Porta interna do container
      protocol    = "TCP"
    }

    type = var.service_type
  }
}
