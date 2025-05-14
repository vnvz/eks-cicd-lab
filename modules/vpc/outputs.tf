output "vpc_id" {
  description = "O ID da VPC selecionada."
  value       = data.aws_vpc.selected.id
}

output "cidr_block" {
  description = "O bloco CIDR principal da VPC selecionada."
  value       = data.aws_vpc.selected.cidr_block
}
