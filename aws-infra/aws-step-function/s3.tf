resource "aws_s3_bucket" "website_bucket" {
  bucket = "${var.s3_bucket_prefix}-${var.environment}-${var.default_region}"
  acl = "public-read"

  policy = "${data.template_file.bucket_policy.rendered}"
  force_destroy = false

  website {
    // A hostname to redirect all website requests for this bucket to.
    //redirect_all_requests_to = "https://${var.www_domain_name}"

    // Here we tell S3 what to use when a request comes in to the root
    index_document = "index.html"
    // The page to serve up if a request results in an error or a non-existing
    error_document = "error.html"
  }

  versioning {
    enabled = "${var.versioning_enabled}"
  }

  lifecycle_rule {
    id      = "file"
    enabled = "${var.lifecycle_rule_enabled}"
    prefix  = "${var.prefix}"

    noncurrent_version_expiration {
      days = "${var.noncurrent_version_expiration_days}"
    }
  }

  tags = "${local.common_tags}"
}

resource "aws_s3_bucket_object" "static_content" {
  bucket = "${aws_s3_bucket.website_bucket.id}"
  key = "/"
  source = "${file("static-website/")}"
}