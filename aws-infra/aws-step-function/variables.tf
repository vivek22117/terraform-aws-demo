//Global Variables
variable "profile" {
  type        = "string"
  description = "AWS Profile name for credentials"
}

variable "environment" {
  type        = "string"
  description = "AWS Profile name for credentials"
}

variable "step-function-name" {
  type = "string"
  description = "Name of the step function"
}

variable "email-reminder-lambda" {
  type = "string"
  description = "Name of lambda function for Email Reminder"
}

variable "sms-reminder-lambda" {
  type = "string"
  description = "Name of Lambda function for SMS Reminder"
}

variable "memory-size" {
  type = "string"
  description = "Lambda memory size"
}

variable "time-out" {
  type = "string"
  description = "Lambda time out"
}

variable "allowed_ips" {
  type = "list"
  description = "List of ips allow"
}

variable "versioning_enabled" {
  type = "string"
  description = "Specify version enabled or not"
}

variable "lifecycle_rule_enabled" {
  type = "string"
  description = "Specify lifecycle enabled or not"
}

variable "prefix" {
  type = "string"
  description = "S3 prefix considered for Lifecycle Rule"
}

variable "noncurrent_version_expiration_days" {
  type = "string"
}

//Default Variables
variable "default_region" {
  type    = "string"
  default = "us-east-1"
}

variable "s3_bucket_prefix" {
  type    = "string"
  default = "ddsolutions-tfstate"
}

variable "sms-lambda-bucket-key" {
  type = "string"
  default = "lambda/sms-reminder-lambda.zip"
}


//Local variables
locals {
  common_tags = {
    owner       = "Vivek"
    team        = "TeamConcept"
    environment = "${var.environment}"
  }
}