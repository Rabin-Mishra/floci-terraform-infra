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
    ec2                    = "http://localhost:4566"
    rds                    = "http://localhost:4566"
    iam                    = "http://localhost:4566"
    sts                    = "http://localhost:4566"
    s3                     = "http://localhost:4566"
    elasticloadbalancing   = "http://localhost:4566"
    elasticloadbalancingv2 = "http://localhost:4566"
    route53                = "http://localhost:4566"
    acm                    = "http://localhost:4566"
  }
}
