resource "aws_s3_bucket" "main" {
  bucket = "${var.s3_bucket_name}"
  acl    = "private"

  tags = "${local.common_tags}"

  region = "${var.default_region}"
}
