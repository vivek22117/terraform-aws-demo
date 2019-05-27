//Lambda function for Email Notification
resource "aws_lambda_function" "email_reminder" {
  function_name = "${var.email-reminder-lambda}"
  handler = "email-reminder-lambda.lambda_handler"

  filename = "${data.archive_file.lambda_for_email.output_path}"
  source_code_hash = "${data.archive_file.lambda_for_email.output_base64sha256}"
  role = "${aws_iam_role.lambda_access_role.arn}"

  memory_size = "${var.memory-size}"
  runtime = "python3.7"
  timeout = "${var.time-out}"

  tags = "${local.common_tags}"
}


//Lambda function for SMS Notification
resource "aws_lambda_function" "sms_reminder" {
  function_name = "${var.sms-reminder-lambda}"
  handler = ""
  role = ""
  runtime = ""
}