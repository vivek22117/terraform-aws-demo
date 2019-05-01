output "s3_bucket_arn" {
  value = "${aws_s3_bucket.main.arn}"
}

output "dynamoDB_arn" {
  value = "${aws_dynamodb_table.dynamodb-terraform-state-lock.arn}"
}

output "dynamoDB_name" {
  value = "${aws_dynamodb_table.dynamodb-terraform-state-lock.name}"
}

output "terraform_access_role" {
  value = "${aws_iam_role.terraform_access_role.arn}"
}