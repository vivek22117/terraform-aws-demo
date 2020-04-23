provider "aws" {
  region  = var.default_region
  profile = var.profile

  version = ">=2.22.0"
}

terraform {
  required_version = ">= 0.12"

  backend "s3" {
    profile        = "qa-admin"
    bucket         = "eks-doubledigit-tfstate-eks-dev-us-east-1"
    dynamodb_table = "eks-doubledigit-tfstate-eks-dev-us-east-1"
    key            = "state/dev/eks-backend/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = "true"
  }
}

