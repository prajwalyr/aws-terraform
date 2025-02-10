output "elastic_ip" {
  value = aws_eip.jenkins_eip.public_ip
}

output "volume_id" {
  value = aws_instance.jenkins.root_block_device[0].volume_id
}