output "s3_bucket_arn" {
  value = "${aws_s3_bucket.main.arn}"
}

output "dynamoDB_arn" {
  value = "${aws_dynamodb_table.dynamodb-terraform-state-lock.arn}"
}