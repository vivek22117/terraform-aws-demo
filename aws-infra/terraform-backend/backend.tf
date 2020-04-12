#####=====================Terraform tfstate backend S3===================#####
resource "aws_s3_bucket" "tf_state_bucket" {
  bucket = "${var.tf_s3_bucket_prefix}-${var.environment}-${var.default_region}"
  acl    = "private"
  region = var.default_region

  force_destroy = false

  lifecycle {
    prevent_destroy = "true"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
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

  tags = merge(local.common_tags, map("name", "tf-state-bucket-${var.environment}"))
}

#####=========================DynamoDB Table for tfstate state lock=====================#####
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name           = "${var.dyanamoDB_prefix}-${var.environment}-${var.default_region}"
  read_capacity  = 2
  write_capacity = 2

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = merge(local.common_tags, map("name", "tf-state-db-${var.environment}"))
}

#####==================Artifactory Bucket for Dev Environment=====================#####
resource "aws_s3_bucket" "s3_artifactory_bucket" {
  bucket = "${var.artifactory_bucket_prefix}-${var.environment}-${var.default_region}"
  acl    = "private"
  region = var.default_region

  force_destroy = false

  lifecycle {
    prevent_destroy = "true" // Terraform meta parameter
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
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

  tags = merge(local.common_tags, map("name", "aritifactory-bucket-${var.environment}"))
}


#####==================DataLake S3 Bucket for Dev Environment=====================#####
resource "aws_s3_bucket" "s3_dataLake_bucket" {
  bucket = "${var.dataLake_bucket_prefix}-${var.environment}-${var.default_region}"
  acl    = "private"
  region = var.default_region

  force_destroy = false

  lifecycle {
    prevent_destroy = "true" // Terraform meta parameter
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true
    id      = "data"
    prefix  = "data/"

    transition {
      days          = 30
      storage_class = "ONEZONE_IA" #"STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      days = 90
    }

    noncurrent_version_expiration {
      days = 1
    }
  }

  tags = merge(local.common_tags, map("name", "datalake-bucket-${var.environment}"))
}


