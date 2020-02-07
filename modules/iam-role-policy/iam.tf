resource "aws_iam_policy" "iam_access_policy" {
  name = var.policy_name
  policy = templatefile(var.policy_path, jsonencode(var.policy_vars))
}

resource "aws_iam_role" "iam_access_role" {
  name = var.role_name
  path = "/"
  assume_role_policy = templatefile(var.role_path, jsonencode(var.role_vars))
}