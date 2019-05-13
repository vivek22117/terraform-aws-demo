/*
resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "JenkinsSlavesAccessProfile"
  role = "${aws_iam_role.role.name}"
}

resource "aws_iam_role" "role" {
  name = "JenkinsSlavesRole"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "jenkins_access_policy" {
  name = "JenkinsAccessPolicy"
  role = "${aws_iam_role.role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": "*",
      "Action": "*"
    }
  ]
}
EOF
}
*/
