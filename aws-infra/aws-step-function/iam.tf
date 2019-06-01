#Define Policy and Role for Step Function
resource "aws_iam_role" "sf_access_role" {
  name = "StepFunctionAccessRole"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "states.${var.default_region}.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_policy" "sf_access_policy" {
  name        = "StepFunctionAccessPolicy"
  description = "Policy to access AWS Resources"
  path        = "/"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "lambda:InvokeFunction",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "policy_role_attach" {
  policy_arn = "${aws_iam_policy.sf_access_policy.arn}"
  role       = "${aws_iam_role.sf_access_role.name}"
}

#Define policy and role for AWS Lambda
resource "aws_iam_role" "lambda_access_role" {
  name = "StepFunctionLambdaAccessRole"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "lambda.amazonaws.com"
            },
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "lambda_access_policy" {
  name = "StepFunctionLambdaAccessPolicy"
  description = "Policy attached for lambda access"
  path = "/"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
          "s3:Get*",
          "s3:Put*",
          "s3:List*"
      ],
      "Resource": "*"
    },
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "ses:*",
        "states:*",
        "sns:*"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_role_attach" {
  policy_arn = "${aws_iam_policy.lambda_access_policy.arn}"
  role       = "${aws_iam_role.lambda_access_role.name}"
}