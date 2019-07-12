######################################################
# Global variables for VPC and Bastion Host
######################################################
variable "profile" {
  type        = string
  description = "AWS Profile name for credentials"
}

variable "default_region" {
  type        = string
  description = "AWS region to deploy resources"
}

#########################################################
# Default variables for backend and SSH key for Bastion #
#########################################################
variable "s3_bucket_prefix" {
  type        = string
  default     = "teamconcept-tfstate"
  description = "Prefix for s3 bucket"
}

######################################################
# Local variables defined                            #
######################################################
variable "team" {
  type        = string
  description = "Owner team for this applcation infrastructure"
}

variable "owner" {
  type        = string
  description = "Owner of the product"
}

variable "environment" {
  type        = string
  description = "Environmet to be used"
}

//Local variables
locals {
  common_tags = {
    owner       = var.owner
    team        = var.team
    environment = var.environment
  }
}

