######################################################
# Global variables for VPC and Bastion Host
######################################################
variable "profile" {
  type        = "string"
  description = "AWS Profile name for credentials"
}

variable "default_region" {
  type        = "string"
  description = "AWS region to deploy resources"
}

variable "cidr_block" {
  type        = "string"
  description = "Cidr range for vpc"
}

variable "instance_tenancy" {
  type        = "string"
  description = "Type of instance tenancy required default/dedicated"
}

variable "enable_dns" {
  type        = "string"
  description = "To use private DNS within the VPC"
}

variable "support_dns" {
  type        = "string"
  description = "To use private DNS support within the VPC"
}

variable "available_zones" {
  type        = "list"
  description = "Name of regions to be used for infrastructure"
}

variable "enable_nat_gateway" {
  type        = "string"
  description = "want to create nat-gateway or not"
}

variable "bastion_instance_type" {
  type        = "string"
  description = "Instance type for Bastion Host"
}

variable "environment" {
  type        = "string"
  description = "Environmet to be used"
}

variable "team" {
  type        = "string"
  description = "Owner team for this applcation infrastructure"
}

variable "owner" {
  type        = "string"
  description = "Owner of the product"
}

#########################################################
# Default variables for backend and SSH key for Bastion #
#########################################################
variable "s3_bucket_prefix" {
  type        = "string"
  default     = "teamconcept-tfstate"
  description = "Prefix for s3 bucket"
}
