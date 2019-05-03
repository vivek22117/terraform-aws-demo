//Global Variables
variable "profile" {
  type        = "string"
  description = "AWS Profile name for credentials"
}

variable "environment" {
  type        = "string"
  description = "Environmet to be used"
}

variable "cidr_block" {
  type        = "string"
  description = "Cidr range for vpc"
}

//Default Variables
variable "owner" {
  type        = "string"
  description = "Owner of the product"
  default     = "Vivek"
}

variable "s3_bucket_prefix" {
  type        = "string"
  default     = "doubledigit-tfstate"
  description = "Prefix for s3 bucket"
}

variable "default_region" {
  type    = "string"
  default = "us-east-1"
}

variable "available_zones" {
  type        = "list"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
  description = "Name of regions to be used for infrastructure"
}

//Local variables
locals {
  common_tags = {
    owner       = "Vivek"
    team        = "TeamConcept"
    environment = "${var.environment}"
  }
}
