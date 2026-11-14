terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "me" {}

module "vpc" {
  source      = "../../modules/vpc"
  environment = "dev"

  tags = {
    Project = "cloud-cost-optimizer"
  }
}

output "account_id" {
  value = data.aws_caller_identity.me.account_id
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}