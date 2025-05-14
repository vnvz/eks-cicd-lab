variable "app_name" {
  description = "Nome base para os recursos Kubernetes (deployment, service, labels)."
  type        = string
  default     = "getting-started-app"
}

variable "app_image" {
  description = "Imagem Docker a ser usada no deployment."
  type        = string
  default     = "vnvzz/getting-started"
}

variable "namespace" {
  description = "Namespace Kubernetes onde os recursos serão criados."
  type        = string
  default     = "default"
}

variable "replicas" {
  description = "Número de réplicas desejadas para o deployment."
  type        = number
  default     = 2
}

variable "container_port" {
  description = "Porta que o container expõe."
  type        = number
  default = 3000
}

variable "service_port" {
  description = "Porta que o Service exporá."
  type        = number
  default     = 80
}

variable "service_type" {
  description = "Tipo do Service Kubernetes (LoadBalancer, NodePort, ClusterIP)."
  type        = string
  default     = "LoadBalancer"
}

variable "labels" {
  description = "Labels a serem aplicadas aos recursos."
  type        = map(string)
  default     = {}
}
