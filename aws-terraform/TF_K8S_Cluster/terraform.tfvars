# AWS Configuration
aws_region = "us-west-2"

# EKS Cluster Configuration
cluster_name    = "authentik-cluster"
node_group_name = "authentik-node-group"
instance_types  = ["t3.medium"]
desired_size    = 2
max_size        = 3
min_size        = 1

# PostgreSQL Configuration
postgresql_user = "authentik"
postgresql_pass = "admin@123"  # Replace with a secure password
postgresql_db   = "authentik"
postgresql_storage_size = "10Gi"

# Authentik Configuration
authentik_storage_size = "10Gi"

# Backup Configuration
s3_bucket_name = "authentik-backups"  # Replace with a unique S3 bucket name