resource "aws_instance" "jenkins" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.security_group]

  root_block_device {
    volume_size = var.volume_size
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y git docker
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ec2-user
              cd /home/ec2-user
              git clone https://github.com/vdespa/install-jenkins-docker.git
              cd install-jenkins-docker
              docker-compose up -d
              EOF

  tags = {
    Name = "Jenkins-Server"
  }
}

resource "aws_eip" "jenkins_eip" {
  instance = aws_instance.jenkins.id
}