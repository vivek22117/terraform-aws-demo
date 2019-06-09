module "vpc-dev" {
  source = "../../../modules/module.vpc"

  profile     = "${var.profile}"
  environment = "${var.environment}"
  default_region = "${var.default_region}"

  cidr_block      = "${var.cidr_block}"
  available_zones = "${var.available_zones}"
  instance_tenancy = "${var.instance_tenancy}"
  enable_dns = "${var.enable_dns}"
  support_dns = "${var.support_dns}"
  enable_nat_gateway = "${var.enable_nat_gateway}"

  team  = "${var.team}"
  owner = "${var.owner}"

  bastion_instance = "${var.bastion_instance}"
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
