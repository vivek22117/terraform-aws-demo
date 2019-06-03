resource "aws_s3_bucket" "website_bucket" {
  depends_on = ["data.template_file.bucket_policy"]

  bucket = "${var.s3_static_content}-${var.environment}-${var.default_region}"
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
    id      = "staticFile"
    enabled = "${var.lifecycle_rule_enabled}"
    prefix  = "${var.prefix}"

    noncurrent_version_expiration {
      days = "${var.noncurrent_version_expiration_days}"
    }
  }

  tags = "${local.common_tags}"
}

resource "aws_s3_bucket_object" "index_file" {
  bucket = "${aws_s3_bucket.website_bucket.id}"
  source = "static-website/index.html"
  key = "index.html"
  content_type = "text/html"
  depends_on = [
    "aws_s3_bucket.website_bucket"
  ]
}

resource "aws_s3_bucket_object" "error_file" {
  bucket = "${aws_s3_bucket.website_bucket.id}"
  source = "static-website/error.html"
  key = "error.html"
  content_type = "text/html"
  depends_on = [
    "aws_s3_bucket.website_bucket"
  ]
}

resource "aws_s3_bucket_object" "css_file" {
  bucket = "${aws_s3_bucket.website_bucket.id}"
  source = "static-website/main.css"
  key = "main.css"
  content_type = "text/css"
  depends_on = [
    "aws_s3_bucket.website_bucket"
  ]
}

resource "aws_s3_bucket_object" "image_file" {
  bucket = "${aws_s3_bucket.website_bucket.id}"
  source = "static-website/cat.png"
  key = "cat.png"
  content_type = "image/png"
  depends_on = [
    "aws_s3_bucket.website_bucket"
  ]
}

resource "aws_s3_bucket_object" "form_file" {
  bucket = "${aws_s3_bucket.website_bucket.id}"
  source = "static-website/formlogic.js"
  key = "formlogic.js"
  content_type = "text/js"
  depends_on = [
    "aws_s3_bucket.website_bucket"
  ]
}