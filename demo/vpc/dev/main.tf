

module "vpc-dev" {
  source = "../../../samples/module.vpc"

  profile     = "${var.profile}"
  environment = "${var.environment}"

  cidr_block      = "${var.cidr_block}"
  available_zones = "${var.available_zones}"

  team  = "${var.team}"
  owner = "${var.owner}"
}

data "terraform_remote_state" "s3" {
  backend = "s3"

  config {
    profile = "doubledigit"
    bucket = "${var.s3_bucket_prefix}-${var.environment}-${var.default_region}"
    key    = "state/${var.environment}/aws/terraform.tfstate"
    region = "${var.default_region}"
  }
}
