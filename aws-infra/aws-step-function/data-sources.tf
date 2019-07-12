//Read lambda file and replace variables
data "template_file" "api_lambda" {
  template = file("${path.module}/templates/api-handler-lambda.py")

  vars = {
    sf-arn = aws_sfn_state_machine.sfn_state_machine.id
  }
}

resource "local_file" "rendered_api_lambda" {
  filename = "${path.module}/lambda-function/api-handler-lambda.py"
  content  = data.template_file.api_lambda.rendered
}

//ZIP file for Step Function Lambda
data "archive_file" "lambda_for_sf" {
  output_path = "lambda-function/api-handler-lambda.zip"
  source_file = "${path.module}/lambda-function/api-handler-lambda.py"
  type        = "zip"
  depends_on  = [local_file.rendered_api_lambda]
}

data "template_file" "website_formlogic" {
  template = file("${path.module}/templates/formlogic.js.tpl")

  vars = {
    api-gateway-api = aws_api_gateway_deployment.reminders-api-dev-deployment.invoke_url
  }
}

resource "local_file" "rendered_formlogic_js" {
  filename = "${path.module}/static-website/formlogic.js"
  content  = data.template_file.website_formlogic.rendered
}

//ZIP file for email lambda
data "archive_file" "lambda_for_email" {
  type        = "zip"
  source_file = "lambda-function/email-reminder-lambda.py"
  output_path = "lambda-function/email-reminder-lambda.zip"
}

//ZIP file for sms lambda
data "archive_file" "lambda_for_sms" {
  output_path = "lambda-function/sms-reminder-lambda.zip"
  source_file = "lambda-function/sms-reminder-lambda.py"
  type        = "zip"
}

//Read S3 Bucket JSON Policy document
data "template_file" "bucket_policy" {
  template = file("scripts/bucket-policy.json")

  vars = {
    bucket      = var.s3_static_content
    environment = var.environment
    region      = var.default_region
    allowed_ips = var.allowed_ips
  }
}

//Read Json cloudformation template for SNS
data "template_file" "cft_sns_stack" {
  template = file("${path.module}/templates/sns-cft.json.tpl")

  vars = {
    display_name = var.display_name
    subscriptions = join(
      ",",
      formatlist(
        "{ \"Endpoint\": \"%s\", \"Protocol\": \"%s\"  }",
        var.mobile_numbers,
        var.protocol,
      ),
    )
  }
}

//Remote state to fetch s3 deploy bucket
data "terraform_remote_state" "backend" {
  backend = "s3"

  config = {
    profile = "doubledigit"
    bucket  = "${var.s3_bucket_prefix}-${var.environment}-${var.default_region}"
    key     = "state/${var.environment}/aws/terraform.tfstate"
    region  = var.default_region
  }
}

