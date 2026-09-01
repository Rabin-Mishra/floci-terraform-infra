module "networking" {
  source              = "./networking"
  vpc_cidr            = var.vpc_cidr
  vpc_name            = var.vpc_name
  cidr_public_subnet  = var.cidr_public_subnet
  cidr_private_subnet = var.cidr_private_subnet
  availability_zones  = var.availability_zones
}

module "security_groups" {
  source = "./security-groups"
  vpc_id = module.networking.vpc_id
}

module "jenkins" {
  source             = "./jenkins"
  ami_id             = var.ec2_ami_id
  instance_type      = "t2.micro"
  tag_name           = "floci-infra-jenkins-ec2"
  public_key         = var.public_key
  subnet_id          = module.networking.public_subnet_id[0]
  security_group_ids = [module.security_groups.ssh_http_https_sg_id, module.security_groups.jenkins_8080_sg_id]
  user_data          = file("./jenkins-runner-script/jenkins-installer.sh")
}


module "lb_target_group" {
  source                = "./load-balancer-target-group"
  vpc_id                = module.networking.vpc_id
  target_group_name     = "floci-infra-jenkins-tg"
  target_group_port     = 8080
  target_group_protocol = "HTTP"
  ec2_instance_id       = module.jenkins.instance_id
  attachment_port       = 8080

}


module "alb" {
  source             = "./load-balancer"
  lb_name            = "floci-infra-jenkins-alb"
  internal           = false
  security_group_ids = [module.security_groups.ssh_http_https_sg_id]
  subnet_ids         = module.networking.public_subnet_id
  target_group_arn   = module.lb_target_group.target_group_arn
  listener_port      = 80
  listener_protocol  = "HTTP"

}


module "hosted_zone" {
  source      = "./hosted-zone"
  domain_name = "jenkins.floci-infra.local"
  lb_dns_name = module.alb.lb_dns_name
  lb_zone_id  = module.alb.lb_zone_id

}


module "rds" {
  source            = "./rds"
  db_identifier     = "floci-infra-db"
  db_username       = var.db_username
  db_password       = var.db_password
  db_name           = var.db_name
  allocated_storage = 20
  instance_class    = "db.t3.micro"
  engine            = "mysql"

}
