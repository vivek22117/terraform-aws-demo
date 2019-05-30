//Global Variables
variable "profile" {
  type        = "string"
  description = "AWS Profile name for credentials"
}

variable "environment" {
  type        = "string"
  description = "Environmet to be used"
  default     = "dev"
}

//Default Variables
variable "s3_bucket_prefix" {
  type        = "string"
  default     = "teamconcept-tfstate"
  description = "Prefix for s3 bucket"
}

variable "dyanamoDB_prefix" {
  type        = "string"
  default     = "teamconcept-tfstate"
  description = "Pefix for dynamoDB Table"
}

variable "default_region" {
  type    = "string"
  default = "us-east-1"
}

//Local variables
locals {
  common_tags = {
    owner       = "Vivek"
    team        = "TeamConcept"
    environment = "${var.environment}"
  }
}
