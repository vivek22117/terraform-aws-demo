resource "aws_vpc" "dev_vpc" {
  cidr_block           = "${var.cidr_block}"
  enable_dns_hostnames = true

  tags {
    Name  = "VPC_${var.environment}_${var.cidr_block}"
    owner = "${var.owner}"
  }
}

######################################################
# Enable access to or from the Internet for instances
# in public subnets
######################################################
resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = "${aws_vpc.dev_vpc.id}"

  tags {
    Name = "IGW-${var.environment}"
  }
}

//Artifactory Bucket for Dev Environment
resource "aws_s3_bucket" "s3_deploy_bucket" {
  bucket = "${var.artifactory_bucket_prefix}-${var.environment}-${var.default_region}"
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
