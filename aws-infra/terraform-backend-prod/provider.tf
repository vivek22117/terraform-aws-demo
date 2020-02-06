provider "aws" {
  region  = var.default_region
  profile = var.profile

  version = ">=2.22.0"
}

terraform {
  required_version = ">= 0.12"

  backend "s3" {
    profile        = "admin"
    bucket         = "doubledigit-tfstate-dev-us-east-1"
    dynamodb_table = "doubledigit-tfstate-dev-us-east-1"
    key            = "state/prod/backend/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = "true"
  }
}

