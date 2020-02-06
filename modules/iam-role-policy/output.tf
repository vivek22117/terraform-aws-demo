output "iam_policy_arn" {
  value = aws_iam_policy.iam_access_policy.arn
}

output "iam_role_arn" {
  value = aws_iam_role.iam_access_role.arn
}

output "iam_policy_name" {
  value = aws_iam_policy.iam_access_policy.name
}

output "iam_role_name" {
  value = aws_iam_role.iam_access_role.name
}