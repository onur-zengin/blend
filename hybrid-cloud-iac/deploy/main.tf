terraform {
  backend "s3" {
    bucket         = "tfstate-hybrid-nw"
    key            = "hybrid-nw.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "tfstate-lock_hybrid-nw"
  }
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

locals {
  prefix = "${var.prefix}-${terraform.workspace}"
  common_tags = {
    Environment = terraform.workspace
    Owner       = var.contact
    ManagedBy   = "Terraform"
  }
}