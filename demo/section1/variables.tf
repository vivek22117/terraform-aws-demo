
//Global Variables
variable "profile" {
  type        = "string"
  description = "AWS Profile name for credentials"
}

variable "environment" {
  type        = "string"
  description = "AWS Profile name for credentials"
}

//Default Variables
variable "default_region" {
  type    = "string"
  default = "us-east-1"
}

//Local variables for dynamic value
locals {
  common_tags = {
    owner       = "Vivek"
    team        = "TeamConcept"
    environment = "${var.environment}"
  }
}

