resource "aws_eks_node_group" "this" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  instance_types = var.instance_types
  ami_type       = var.ami_type
  disk_size      = var.disk_size

  scaling_config {
    min_size     = var.scaling_min_size
    max_size     = var.scaling_max_size
    desired_size = var.scaling_desired_size
  }

  force_update_version = false

  tags = merge(
    {
      "Name" = "${var.cluster_name}-${var.node_group_name}"
    },
    var.tags
  )

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}
