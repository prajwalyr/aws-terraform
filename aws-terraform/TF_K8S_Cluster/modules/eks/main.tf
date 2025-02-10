resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  
  vpc_config {
    subnet_ids = aws_subnet.eks_subnets[*].id
  }
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = aws_subnet.eks_subnets[*].id

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  instance_types = var.instance_types
}