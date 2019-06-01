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

//ZIP file for Step Function Lambda
data "archive_file" "lambda_for_sf" {
  output_path = "lambda-function/api-handler-lambda.zip"
  source_file = "lambda-function/api-handler-lambda.py"
  type = "zip"
}

//Read S3 Bucket JSON Policy document
data "template_file" "bucket_policy" {
  template = "${file("scripts/bucket-policy.json")}"

  vars {
    bucket = "${var.s3_static_content}"
    environment = "${var.environment}"
    region = "${var.default_region}"
    allowed_ips = "${var.allowed_ips}"
  }
}

//Remote state to fetch s3 deploy bucket
data "terraform_remote_state" "backend" {
  backend = "s3"

  config {
    profile = "doubledigit"
    bucket  = "${var.s3_bucket_prefix}-${var.environment}-${var.default_region}"
    key     = "state/${var.environment}/aws/terraform.tfstate"
    region  = "${var.default_region}"
  }
}