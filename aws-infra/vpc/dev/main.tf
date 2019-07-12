module "vpc-dev" {
  source = "../../../modules/module.vpc"

  profile        = var.profile
  environment    = var.environment
  default_region = var.default_region

  cidr_block         = var.cidr_block
  available_zones    = var.available_zones
  instance_tenancy   = var.instance_tenancy
  enable_dns         = var.enable_dns
  support_dns        = var.support_dns
  enable_nat_gateway = var.enable_nat_gateway

  team  = var.team
  owner = var.owner

  bastion_instance_type = var.bastion_instance_type
}
