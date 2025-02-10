resource "aws_backup_vault" "jenkins_vault" {
  name = "jenkins_backup_vault"
}

resource "aws_backup_plan" "daily" {
  name = var.backup_plan_name

  rule {
    rule_name         = "daily-snapshot"
    target_vault_name = aws_backup_vault.jenkins_vault.name
    schedule          = "cron(0 0 * * ? *)"
  }
}

# Create an IAM role for AWS Backup
resource "aws_iam_role" "backup" {
  name = "aws_backup_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "backup.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "backup_policy" {
  role       = aws_iam_role.backup.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

data "aws_caller_identity" "current" {}

resource "aws_backup_selection" "ebs_backup" {
  name           = "jenkins-ebs-backup"
  iam_role_arn   = aws_iam_role.backup.arn
  plan_id = aws_backup_plan.daily.id

  resources = [
    "arn:aws:ec2:${var.aws_region}:${data.aws_caller_identity.current.account_id}:volume/${var.volume_id}"
  ]
}
