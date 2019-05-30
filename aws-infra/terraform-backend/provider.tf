provider "aws" {
  region  = "${var.default_region}"
  profile = "${var.profile}"
  version = "2.7.0"
}

terraform {
  required_version = ">= 0.11.13"

  backend "s3" {
    profile        = "doubledigit"
    bucket         = "teamconcept-tfstate-dev-us-east-1"
    dynamodb_table = "teamconcept-tfstate-dev-us-east-1"
    key            = "state/dev/aws/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = "true"
  }
}
