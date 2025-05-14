variable "cluster_name" {
  description = "Nome do cluster EKS ao qual este Node Group pertence."
  type        = string
}

variable "node_group_name" {
  description = "Nome único para o EKS Managed Node Group."
  type        = string
}

variable "node_role_arn" {
  description = "ARN da IAM Role que os nós do Node Group assumirão."
  type        = string
}

variable "subnet_ids" {
  description = "Lista de IDs de Subnet onde os nós serão lançados."
  type        = list(string)
}

variable "instance_types" {
  description = "Lista de tipos de instância EC2 para usar nos nós."
  type        = list(string)
  default     = ["t3.small"] # Padrão conforme solicitado anteriormente
}

variable "scaling_min_size" {
  description = "Número mínimo de nós no grupo de escalonamento."
  type        = number
}

variable "scaling_max_size" {
  description = "Número máximo de nós no grupo de escalonamento."
  type        = number
}

variable "scaling_desired_size" {
  description = "Número desejado de nós no grupo de escalonamento."
  type        = number
}

variable "ami_type" {
  description = "Tipo de AMI a ser usada (ex: AL2_x86_64, AL2_x86_64_GPU, BOTTLEROCKET_x86_64)."
  type        = string
  default     = "AL2_x86_64" # AMI Linux 2 padrão otimizada para EKS
}

variable "disk_size" {
  description = "Tamanho do disco (em GiB) para os nós."
  type        = number
  default     = 20 # Tamanho padrão
}

variable "tags" {
  description = "Tags a serem aplicadas ao Node Group e às instâncias EC2 subjacentes."
  type        = map(string)
  default     = {}
}
