//ZIP file for email lambda
data "archive_file" "lambda_for_email" {
  type = "zip"
  source_file = "lambda-function/email-reminder-lambda.py"
  output_path = "lambda-function/email-reminder-lambda.zip"
}

//ZIP file for sms lambda
data "archive_file" "lambda_for_sms" {
  output_path = "lambda-function/sms-reminder-lambda.zip"
  source_file = "lambda-function/sms-reminder-lambda.py"
  type = "zip"
}

//Remote state to fetch s3 deploy bucket
data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    profile = "doubledigit"
    bucket  = "${var.s3_bucket_prefix}-${var.environment}-${var.default_region}"
    key     = "state/${var.environment}/vpc/terraform.tfstate"
    region  = "${var.default_region}"
  }
}