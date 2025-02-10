resource "helm_release" "authentik" {
  name       = "authentik"
  repository = "https://charts.goauthentik.io"
  chart      = "authentik"

  set {
    name  = "postgresql.enabled"
    value = "false"
  }

  set {
    name  = "externalDatabase.host"
    value = var.postgresql_host
  }

  set {
    name  = "externalDatabase.user"
    value = var.postgresql_user
  }

  set {
    name  = "externalDatabase.password"
    value = var.postgresql_pass
  }

  set {
    name  = "externalDatabase.database"
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