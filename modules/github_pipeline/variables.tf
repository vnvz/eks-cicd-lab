variable "name" {
  description = "Nome da IAM Role do pipeline GitHub Actions"
  type        = string
}
variable "repository" {
  description = "GitHub repo no formato org/repo (usado na condição do OIDC)"
  type        = string
}
variable "branch" {
  description = "Branch que pode assumir a Role"
  type        = string
  default     = "main"
}
variable "tags" {
  description = "Tags para essa Role"
  type        = map(string)
  default     = {}
}
