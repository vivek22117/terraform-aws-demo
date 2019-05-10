
resource "aws_s3_bucket" "s3" {
  bucket = "teamconcept-tf-state"
  acl    = "private"
  region = "${var.default_region}"

  tags   = "${local.common_tags}"
}

/*resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name           = "teamconcept-tf-state"
  read_capacity  = 5
  write_capacity = 5

  hash_key = "LockID"

  "attribute" {
    name = "LockID"
    type = "S"
  }

  tags {
    Name = "DynamoDb Terraform state lock Table"
  }
}*/
