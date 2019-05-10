module "vpc_one" {
  source = "../../samples/module.vpc"

  profile     = "${var.profile}"
  environment = "${var.default_region}"

  cidr_block  = "${var.cidr_block}"
  available_zones = "${var.available_zones}"

  team = "${var.team}"
  owner = "${var.owner}"
}