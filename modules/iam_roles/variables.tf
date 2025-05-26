variable "cluster_name" {
  description = "Nome do cluster EKS para usar em tags/nomes (opcional)."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags a serem aplicadas à IAM role."
  type        = map(string)
  default     = {}
}
