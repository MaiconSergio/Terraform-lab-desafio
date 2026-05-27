terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.46.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
    default_tags {
    tags = {
      Environment = "dev"
      Owner       = "aws-network-desafio-Michael"
    }
  }
}