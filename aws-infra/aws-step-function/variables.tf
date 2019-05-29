variable "step-function-name" {
  type = "string"
  description = "Name of the step function"
}

variable "environment" {
  type        = "string"
  description = "AWS Profile name for credentials"
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

//Default Variables
variable "default_region" {
  type    = "string"
  default = "us-east-1"
}

variable "s3_bucket_prefix" {
  type    = "string"
  default = "teamconcept-tfstate"
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