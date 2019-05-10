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

variable "available_zones" {
  type        = "list"
  description = "Name of regions to be used for infrastructure"
}

variable "team" {
  type    = "string"
  description = "Owner team for this applcation infrastructure"
}

variable "owner" {
  type        = "string"
  description = "Owner of the product"
}

//Default Variables
variable "s3_bucket_prefix" {
  type        = "string"
  default     = "doubledigit-tfstate"
  description = "Prefix for s3 bucket"
}

variable "default_region" {
  type    = "string"
  default = "us-east-1"
}
