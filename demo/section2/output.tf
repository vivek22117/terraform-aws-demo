output "s3_arn" {
  value = "${aws_s3_bucket.s3.arn}"
}

output "db_arn" {
  value = "${aws_dynamodb_table.teamconcept-tf-state-lock.arn}"
}