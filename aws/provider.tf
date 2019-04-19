provider "aws" {
  region = "us-east-1"
}


terraform {
  required_version = "0.11.13"

  backend "s3" {
    bucket = "doubledigit-tfstate-dev-us-east-1"
    key = "dev/aws"
    region = "us-east-1"
    encrypt = "true"
  }
}
