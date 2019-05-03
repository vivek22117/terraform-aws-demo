module "vpc_one" {
  source = "../module.vpc"

  profile     = "${var.profile}"
  environment = "${var.default_region}"
  cidr_block  = "${var.cidr_block}"
}
