variable "name" {
  description = "Nome do repositório ECR"
  type        = string
}
variable "tags" {
  description = "Tags a aplicar ao repositório"
  type        = map(string)
  default     = {}
}
