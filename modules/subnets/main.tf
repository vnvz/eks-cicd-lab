data "aws_subnet" "selected" {
  for_each = toset(var.subnet_ids)

  id = each.key
}
