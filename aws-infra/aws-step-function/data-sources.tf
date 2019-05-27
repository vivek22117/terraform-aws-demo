resource "template_file" "sf_defination" {
  template = "${file("scripts/step-function.json")}"

  vars {
    lambda-arn-email = "${aws_lambda_function.email_reminder.arn}"
  }

}

data "archive_file" "lambda_for_email" {
  type = "zip"
  source_file = "lambda-function/email-reminder-lambda.py"
  output_path = "lambda-function/email-reminder-lambda"
}
