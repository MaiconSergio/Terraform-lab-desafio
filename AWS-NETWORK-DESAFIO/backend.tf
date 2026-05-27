terraform {
  backend "s3" {
    bucket = "michaelsergio-bucket-remotestate"
    key    = "aws-terrafom-desafio/terraform.tfstate"
    region = "us-east-1"
  }
}

