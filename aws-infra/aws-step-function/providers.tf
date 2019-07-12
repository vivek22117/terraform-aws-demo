provider "aws" {
  region  = var.default_region
  profile = var.profile

  version = "2.17.0"
}

provider "template" {
  version = "2.1.2"
}

provider "archive" {
  version = "1.2.2"
}

provider "local" {
  version = "1.2.2"
}

terraform {
  required_version = ">= 0.12" // Terraform version

  backend "s3" {
    profile        = "doubledigit"
    bucket         = "teamconcept-tfstate-dev-us-east-1"
    dynamodb_table = "teamconcept-tfstate-dev-us-east-1"
    key            = "state/dev/step-function/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = "true"
  }
}

