terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}
variable "floci_endpoint" {
  type    = string
  default = "http://localhost:4566"
}
provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  endpoints {
    ec2                    = var.floci_endpoint
    rds                    = var.floci_endpoint
    iam                    = var.floci_endpoint
    sts                    = var.floci_endpoint
    s3                     = var.floci_endpoint
    elasticloadbalancing   = var.floci_endpoint
    elasticloadbalancingv2 = var.floci_endpoint
    route53                = var.floci_endpoint
    acm                    = var.floci_endpoint
  }
}
