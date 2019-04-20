//Global Variables
variable "profile" {
  type        = "string"
  description = "AWS Profile name for credentials"
}

variable "environment" {
  type        = "string"
  description = "Environmet to be used"
}

//Default Variables
variable "cidr_block" {
  type        = "string"
  default     = "10.0.0.0/20"
  description = "Cidr range for VPC"
}

variable "owner" {
  type        = "string"
  description = "Owner of the product"
  default     = "Vivek"
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
