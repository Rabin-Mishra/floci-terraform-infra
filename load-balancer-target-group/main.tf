variable "vpc_id" {

}
variable "target_group_name" {

}
variable "target_group_port" {

}
variable "target_group_protocol" {

}
variable "ec2_instance_id" {

}
variable "attachment_port" {

}


resource "aws_lb_target_group" "jenkins_tg" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id


  health_check {
    enabled             = true
    path                = "/login"
    port                = "8080"
    healthy_threshold   = 6
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
    matcher             = "200"
  }

  tags = {
    Name = var.target_group_name
  }

}

resource "aws_lb_target_group_attachment" "jenkins_tg_attachment" {
  target_group_arn = aws_lb_target_group.jenkins_tg.arn
  target_id        = var.ec2_instance_id
  port             = var.attachment_port

}


output "target_group_arn" {
  value = aws_lb_target_group.jenkins_tg.arn

}
