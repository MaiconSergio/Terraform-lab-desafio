terraform {
  backend "s3" {
    bucket = "michaelsergio-bucket-remotestate"
    key    = "aws-vm-provisioners-desafio/terraform.tfstate"
    region = "us-east-1"
  }
}


data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "michaelsergio-bucket-remotestate"
    key    = "aws-terrafom-desafio/terraform.tfstate"
    region = "us-east-1"
  }
}


