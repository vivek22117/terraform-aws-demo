####################################################
#     IAM role & policy moudle configuration       #
####################################################
module "iam-role" {
  source = "../../modules/iam-role-policy"

  profile        = var.profile
  environment    = var.environment
  default_region = var.default_region

  policy_name = var.policy_name
  role_name   = var.role_name

  component = var.component
  team      = var.team
}