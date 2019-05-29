resource "aws_s3_bucket" "s3" {
  bucket = "${var.s3_bucket_prefix}-${var.environment}-${var.default_region}"
  acl    = "private"
  region = "${var.default_region}"

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
    id      = "state"
    prefix  = "state/"

    noncurrent_version_expiration {
      days = 1
    }
  }

  tags   = "${local.common_tags}"
}

resource "aws_dynamodb_table" "teamconcept-tf-state-lock" {
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
