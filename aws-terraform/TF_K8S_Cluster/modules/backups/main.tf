# Create S3 Bucket for Backups
resource "aws_s3_bucket" "backups" {
  bucket = var.s3_bucket_name
}

# Create Persistent Volume Claim for Backups
resource "kubernetes_persistent_volume_claim" "backup_pvc" {
  metadata {
    name = "backup-pvc"
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "5Gi"
      }
    }
  }
}

# Create CronJob for PostgreSQL Backups
resource "kubernetes_cron_job" "postgres_backup" {
  metadata {
    name = "postgres-backup"
  }

  spec {
    schedule = "0 1 * * *" # Every day at 1 AM

    job_template {
      metadata {
        name = "postgres-backup-job"
      }

      spec {
        template {
          metadata {
            name = "postgres-backup-pod"
          }

          spec {
            container {
              name    = "backup"
              image   = "postgres:13"
              command = ["/bin/sh", "-c", "pg_dump -h ${var.postgresql_host} -U ${var.postgresql_user} -d ${var.postgresql_db} > /backup/backup.sql"]

              volume_mount {
                name       = "backup-volume"
                mount_path = "/backup"
              }

              env {
                name  = "PGPASSWORD"
                value = var.postgresql_pass
              }
            }

            volume {
              name = "backup-volume"

              persistent_volume_claim {
                claim_name = kubernetes_persistent_volume_claim.backup_pvc.metadata[0].name
              }
            }

            restart_policy = "OnFailure"
          }
        }
      }
    }
  }
}