//Lambda function for Email Notification
resource "aws_lambda_function" "email_reminder" {
  function_name = var.email-reminder-lambda
  handler       = "email-reminder-lambda.lambda_handler"

  filename         = data.archive_file.lambda_for_email.output_path
  source_code_hash = data.archive_file.lambda_for_email.output_base64sha256
  role             = aws_iam_role.lambda_access_role.arn

  memory_size = var.memory-size
  runtime     = "python3.7"
  timeout     = var.time-out

  environment {
    variables = {
      verified_email = var.verified_email
    }
  }
  tags = local.common_tags
}

//Lambda function for SMS Notification
# adding the lambda archive to the defined bucket
resource "aws_s3_bucket_object" "lambda-package" {
  bucket                 = data.terraform_remote_state.backend.outputs.deploy_bucket_name
  key                    = var.sms-lambda-bucket-key
  source                 = "lambda-function/sms-reminder-lambda.zip"
  server_side_encryption = "AES256"
}

resource "aws_lambda_function" "sms_reminder" {
  depends_on = [aws_s3_bucket_object.lambda-package]

  function_name = var.sms-reminder-lambda
  handler       = "sms-reminder-lambda.lambda_handler"

  s3_bucket = aws_s3_bucket_object.lambda-package.bucket
  s3_key    = aws_s3_bucket_object.lambda-package.key

  role    = aws_iam_role.lambda_access_role.arn
  runtime = "python3.7"
  timeout = var.time-out

  tags = local.common_tags
}

resource "aws_s3_bucket_object" "api-lambda-package" {
  bucket                 = data.terraform_remote_state.backend.outputs.deploy_bucket_name
  key                    = var.api-handler-lambda-bucket-key
  source                 = "lambda-function/api-handler-lambda.zip"
  server_side_encryption = "AES256"
}

//Lambda function for STEP FUN execution
resource "aws_lambda_function" "sf_executor" {
  depends_on = [aws_s3_bucket_object.api-lambda-package]

  function_name = var.step-function-name
  handler       = "api-handler-lambda.lambda_handler"

  s3_bucket = aws_s3_bucket_object.api-lambda-package.bucket
  s3_key    = aws_s3_bucket_object.api-lambda-package.key

  role    = aws_iam_role.lambda_access_role.arn
  runtime = "python3.7"
  timeout = var.time-out

  tags = local.common_tags
}

resource "aws_lambda_permission" "allow_api_gateway" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sf_executor.arn

  # An optional identifier for the permission statement
  statement_id = "AllowExecutionFromApiGateway"

  # The item that is getting this lambda permission
  principal = "apigateway.amazonaws.com"
}

