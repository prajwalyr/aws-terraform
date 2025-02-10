provider "aws" {
  region = var.aws_region
}

module "eks" {
  source = "./modules/eks"

  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  instance_types  = var.instance_types
  desired_size    = var.desired_size
  max_size        = var.max_size
  min_size        = var.min_size
}

module "postgresql" {
  source = "./modules/postgresql"

  cluster_name     = module.eks.cluster_name
  postgresql_user  = var.postgresql_user
  postgresql_pass  = var.postgresql_pass
  postgresql_db    = var.postgresql_db
  storage_size     = var.postgresql_storage_size
}

module "authentik" {
  source = "./modules/authentik"

  cluster_name     = module.eks.cluster_name
  postgresql_host  = module.postgresql.postgresql_host
  postgresql_user  = var.postgresql_user
  postgresql_pass  = var.postgresql_pass
  postgresql_db    = var.postgresql_db
  storage_size     = var.authentik_storage_size
}

module "backups" {
  source = "./modules/backups"

  cluster_name    = module.eks.cluster_name
  postgresql_host = module.postgresql.postgresql_host
  postgresql_user = var.postgresql_user
  postgresql_pass = var.postgresql_pass
  postgresql_db   = var.postgresql_db
  s3_bucket_name  = var.s3_bucket_name
}