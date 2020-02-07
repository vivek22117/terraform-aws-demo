####################################################
#     IAM role & policy moudle configuration       #
####################################################
module "iam-role" {
  source = "../../modules/iam-role-policy"

  profile        = var.profile
  environment    = var.environment
  default_region = var.default_region

  policy_name = var.policy_name
  policy_path = var.policy_path
  policy_vars = var.policy_vars

  role_name   = var.role_name
  role_path = var.role_path
  role_vars = var.role_vars

  component = var.component
  team      = var.team
}