output "s3_bucket_arn" {
  value = aws_s3_bucket.tf_state_bucket.arn
}

output "s3_bucket_name" {
  value = aws_s3_bucket.tf_state_bucket.id
}

output "dataLake_bucket_arn" {
  value = aws_s3_bucket.s3_dataLake_bucket.arn
}

output "dataLake_bucket_name" {
  value = aws_s3_bucket.s3_dataLake_bucket.id
}

output "dynamoDB_arn" {
  value = aws_dynamodb_table.dynamodb-terraform-state-lock.arn
}

output "dynamoDB_name" {
  value = aws_dynamodb_table.dynamodb-terraform-state-lock.name
}

output "terraform_access_role" {
  value = aws_iam_role.terraform_access_role.arn
}

output "deploy_bucket_name" {
  value = aws_s3_bucket.s3_deploy_bucket.id
}

output "deploy_bucket_arn" {
  value = aws_s3_bucket.s3_deploy_bucket.arn
}

