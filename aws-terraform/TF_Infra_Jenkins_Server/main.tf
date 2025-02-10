provider "aws" {
  region = var.aws_region
}

module "jenkins_server" {
  source         = "./modules/ec2-instance"
  instance_type  = var.instance_type
  key_name       = var.key_name
  ami_id         = var.ami_id
  volume_size    = var.volume_size
  subnet_id      = var.subnet_id
  security_group = var.security_group
}

module "ebs_snapshot" {
  aws_region = var.aws_region
  source        = "./modules/ebs-snapshot"
  volume_id     = module.jenkins_server.volume_id
  backup_plan_name = "jenkins-backup"
}