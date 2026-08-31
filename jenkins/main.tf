variable "ami_id" {

}
variable "instance_type" {

}
variable "tag_name" {

}

variable "public_key" {

}
variable "subnet_id" {

}

variable "security_group_ids" {

}

variable "user_data" {

}

resource "aws_key_pair" "jenkins_key" {
  key_name   = "floci-infra-jenkins-key"
  public_key = var.public_key

}

resource "aws_instance" "jenkins" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = aws_key_pair.jenkins_key.key_name
  vpc_security_group_ids = var.security_group_ids
  user_data              = var.user_data


  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  lifecycle {
    ignore_changes = [associate_public_ip_address, metadata_options]
  }

  tags = {
    Name = var.tag_name
  }


}

output "instance_id" {
  value = aws_instance.jenkins.id
}

output "public_ip" {
  value = aws_instance.jenkins.public_ip
}
