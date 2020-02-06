resource "aws_iam_policy" "iam_access_policy" {
  name = var.policy_name
  policy = templatefile("${path.module}/policy-scripts/administrator-policy.json", {})
}

resource "aws_iam_role" "iam_access_role" {
  name = var.role_name
  path = "/"
  assume_role_policy = templatefile("${path.module}/role-scripts/administrator-role.json", {})
}