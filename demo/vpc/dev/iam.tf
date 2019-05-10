resource "aws_iam_role" "ec2_s3_access_role" {
  name = "s3-bucket-access-role"

  assume_role_policy = "${file("EC2S3BucketAccessRole.json")}"
}

resource "aws_iam_policy" "ec2_s3_access_policy" {
  name        = "s3-bucket-access-policy"
  description = "Policy to access s3 bucket from EC2"
  path = "/"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "${data.terraform_remote_state.s3.s3_arn}"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "policy_role_attach" {
  policy_arn = "${aws_iam_policy.ec2_s3_access_policy.arn}"
  role = "${aws_iam_role.ec2_s3_access_role.name}"
}

