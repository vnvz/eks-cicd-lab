variable "aws_region" {
  description = "A região AWS onde os recursos existem/serão criados."
  type        = string
  default     = "eu-central-1"
}

variable "existing_vpc_id" {
  description = "O ID da VPC existente."
  type        = string
  default     = "vpc-6412160f"
}

variable "existing_subnet_ids" {
  description = "Lista de IDs das subnets existentes a serem usadas (geralmente privadas para Node Groups)."
  type        = list(string)
  default = [
    "subnet-556d813f",
    "subnet-ea81afa7"
  ]
}

variable "existing_cluster_sg_id" {
  description = "O ID do Security Group principal do cluster EKS existente."
  type        = string
  default     = "sg-0e50cabbf08b874e2"
}

variable "existing_eks_cluster_name" {
  description = "O nome do cluster EKS existente."
  type        = string
  default = "eksDeepDiveFrankfurt"
}

variable "node_group_name" {
  description = "Nome do EKS Managed Node Group a ser criado."
  type        = string
  default     = "NodeGroupDP017"
}

variable "node_group_instance_types" {
  description = "Tipos de instância para o Node Group."
  type        = list(string)
  default     = ["t3.small"]
}

variable "node_group_scaling_min" {
  description = "Número mínimo de nós no Node Group."
  type        = number
  default     = 1
}

variable "node_group_scaling_max" {
  description = "Número máximo de nós no Node Group."
  type        = number
  default     = 2
}

variable "node_group_scaling_desired" {
  description = "Número desejado de nós no Node Group (inicial)."
  type        = number
  default     = 1
}

variable "node_group_tags" {
  description = "Tags adicionais para aplicar ao Node Group, suas instâncias e a IAM Role associada."
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
    Project   = "EKS-DeepDive-Example"
    "Periodo" = "8"
    "Aluno"   = "vvv-pcgbf"
  }
}

