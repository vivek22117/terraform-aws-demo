#Defining AWS Step function State Machine
resource "aws_sfn_state_machine" "sfn_state_machine" {
  name = "${var.step-function-name}-${var.environment}"

  role_arn = "${aws_iam_role.sf_access_role.arn}"
  definition = "${}"
}

