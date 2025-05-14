output "subnet_ids" {
  description = "Lista de IDs das subnets selecionadas."
  value       = keys(data.aws_subnet.selected)
}

output "subnet_details" {
  description = "Mapa contendo detalhes de cada subnet selecionada (chave é o ID)."
  value       = data.aws_subnet.selected
}
