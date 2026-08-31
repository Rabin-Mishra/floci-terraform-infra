variable "lb_name" {

}
variable "internal" {

}
variable "security_group_ids" {

}
variable "subnet_ids" {

}
variable "target_group_arn" {

}
variable "listener_port" {

}
variable "listener_protocol" {

}

resource "aws_lb" "jenkins_alb" {
  name               = var.lb_name
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids

  tags = {
    Name = var.lb_name
  }
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.jenkins_alb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }

}

output "lb_dns_name" {
  value = aws_lb.jenkins_alb.dns_name

}

output "lb_zone_id" {
  value = aws_lb.jenkins_alb.zone_id

}
