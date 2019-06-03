resource "aws_s3_bucket" "main" {
  bucket = "${var.s3_bucket_prefix}-${var.environment}-${var.default_region}"
  acl    = "private"
  tags   = "${local.common_tags}"
  region = "${var.default_region}"

  force_destroy = false

  lifecycle {
    prevent_destroy = "true"
  }

  server_side_encryption_configuration {
    "rule" {
      "apply_server_side_encryption_by_default" {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true
    id      = "state"
    prefix  = "state/"

    noncurrent_version_expiration {
      days = 1
    }
  }
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name           = "${var.dyanamoDB_prefix}-${var.environment}-${var.default_region}"
  read_capacity  = 5
  write_capacity = 5

  hash_key = "LockID"

  "attribute" {
    name = "LockID"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }

  tags {
    Name = "DynamoDb Terraform state lock Table"
  }
}

//Artifactory Bucket for Dev Environment
resource "aws_s3_bucket" "s3_deploy_bucket" {
  bucket = "${var.artifactory_bucket_prefix}-${var.environment}-${var.default_region}"
  acl    = "private"
  region = "${var.default_region}"

  force_destroy = false

  lifecycle {                               // Terraform meta parameter
    prevent_destroy = "true"
  }

  server_side_encryption_configuration {
    "rule" {
      "apply_server_side_encryption_by_default" {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true
    id      = "deploy"
    prefix  = "deploy/"

    noncurrent_version_expiration {
      days = 1
    }
  }

  tags   = "${local.common_tags}"
}


resource "aws_iam_policy" "terraform_access_policy" {
  name = "TerraformAccessPolicy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "*",
        "Resource": "*"
      }
    ]
}
EOF
}

resource "aws_iam_role" "terraform_access_role" {
  name = "TerraformAccessRole"
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

resource "aws_iam_role_policy_attachment" "terraform_access" {
  policy_arn = "${aws_iam_policy.terraform_access_policy.arn}"
  role       = "${aws_iam_role.terraform_access_role.name}"
}