output "cluster_name" {
  value = module.eks.cluster_name
}

output "postgresql_host" {
  value = module.postgresql.postgresql_host
}

output "authentik_endpoint" {
  value = module.authentik.authentik_endpoint
}