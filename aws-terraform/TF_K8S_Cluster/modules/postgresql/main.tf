resource "helm_release" "postgresql" {
  name       = "postgresql"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"

  set {
    name  = "postgresqlUsername"
    value = var.postgresql_user
  }

  set {
    name  = "postgresqlPassword"
    value = var.postgresql_pass
  }

  set {
    name  = "postgresqlDatabase"
    value = var.postgresql_db
  }

  set {
    name  = "persistence.enabled"
    value = "true"
  }

  set {
    name  = "persistence.size"
    value = var.storage_size
  }
}