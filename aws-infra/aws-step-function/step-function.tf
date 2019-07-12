data "template_file" "sf_defination" {
  template = file("scripts/step-function.json")

  vars = {
    lambda-arn-email = aws_lambda_function.email_reminder.arn
    lambda-arn-sms   = aws_lambda_function.sms_reminder.arn
  }
}

#Defining AWS Step function State Machine
resource "aws_sfn_state_machine" "sfn_state_machine" {
  name = "${var.step-function-name}-${var.environment}"

  role_arn   = aws_iam_role.sf_access_role.arn
  definition = data.template_file.sf_defination.rendered
}

