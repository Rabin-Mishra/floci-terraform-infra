variable "domain_name" {

}
variable "lb_dns_name" {

}
variable "lb_zone_id" {

}

resource "aws_route53_zone" "main" {
  name = "floci-infra.local"

}

resource "aws_route53_record" "jenkins" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.lb_dns_name
    zone_id                = var.lb_zone_id
    evaluate_target_health = true
  }

}


output "hosted_zone_id" {
  value = aws_route53_zone.main.zone_id

}
