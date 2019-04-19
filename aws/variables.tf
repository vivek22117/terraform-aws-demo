//Global Variables
variable "profile" {
  type        = "string"
  description = "AWS Profile name for credentials"
}

variable "environment" {
  type = "string"
  description = "Environmet to be used"
  default = "dev"
}

//Default Variables
variable "s3_bucket_name" {
  type        = "string"
  default     = "doubledigit-tfstate-dev-us-east-1"
  description = "Name of s3 bucket"
}

variable "default_region" {
  type    = "string"
  default = "us-east-1"
}

variable "available_zones" {
  type        = "list"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e"]
  description = "Name of regions to be used for infrastructure"
}

//Local variables
locals {
  common_tags = {
    owner = "Vivek"
    team  = "TeamConcept"
    environment = "${var.environment}"
  }
}
