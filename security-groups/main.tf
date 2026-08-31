variable "vpc_id" {

}

resource "aws_security_group" "ec2_ssh_http_https" {
  name        = "floci-infra-ec2-ssh-http-https"
  vpc_id      = var.vpc_id
  description = "Allow SSH, HTTP and HTTPS inbound traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]


  }
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "floci-infra-ec2-ssh-http-https"
  }
}



resource "aws_security_group" "jenkins_8080" {
  name        = "floci-infra-jenkins-8080"
  vpc_id      = var.vpc_id
  description = "Allow Jenkins inbound traffic on port 8080"

  ingress {
    description = "Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "floci-infra-jenkins-8080"
  }
}

output "ssh_http_https_sg_id" {
  value = aws_security_group.ec2_ssh_http_https.id

}

output "jenkins_8080_sg_id" {
  value = aws_security_group.jenkins_8080.id

}
