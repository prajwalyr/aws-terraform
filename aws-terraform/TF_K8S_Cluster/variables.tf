# AWS Configuration
variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
  default     = "us-east-2"
}

# EKS Cluster Configuration
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "authentik-cluster"
}

variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
  default     = "authentik-node-group"
}

variable "instance_types" {
  description = "Instance types for EKS worker nodes"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "desired_size" {
  description = "Desired number of nodes in the EKS node group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of nodes in the EKS node group"
  type        = number
  default     = 4
}

variable "min_size" {
  description = "Minimum number of nodes in the EKS node group"
  type        = number
  default     = 2
}

# PostgreSQL Configuration
variable "postgresql_user" {
  description = "PostgreSQL username"
  type        = string
  default     = "authentik"
}

variable "postgresql_pass" {
  description = "PostgreSQL password"
  type        = string
  sensitive   = true
}

variable "postgresql_db" {
  description = "PostgreSQL database name"
  type        = string
  default     = "authentik"
}

variable "postgresql_storage_size" {
  description = "Storage size for PostgreSQL"
  type        = string
  default     = "10Gi"
}

# Authentik Configuration
variable "authentik_storage_size" {
  description = "Storage size for Authentik"
  type        = string
  default     = "10Gi"
}

# Backup Configuration
variable "s3_bucket_name" {
  description = "Name of the S3 bucket for backups"
  type        = string
  default     = "authentik-backups"
}