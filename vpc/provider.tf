provider "aws" {
  region  = "${var.default_region}"
  version = "2.7.0"
}

terraform {
  required_version = ">= 0.11.13"

  backend "s3" {
    bucket  = "doubledigit-tfstate-dev-us-east-1"
    key     = "dev/vpc"
    region  = "us-east-1"
    encrypt = "true"
  }
}
