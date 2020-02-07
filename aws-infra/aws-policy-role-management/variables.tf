#####===================Global Variables====================#####
variable "profile" {
  type        = string
  description = "AWS Profile name for credentials"
}

variable "default_region" {
  type        = string
  description = "AWS region to provision"
}

variable "environment" {
  type        = string
  description = "Development environment"
}

#####==================Configration Variables===============#####
variable "policy_name" {
  type        = string
  description = "Name of the IAM policy"
}

variable "policy_path" {
  type = string
  description = "Path for policy document"
}

variable "role_name" {
  type        = string
  description = "Name of the IAM role"
}

variable "role_path" {
  type = string
  description = "Path for role document"
}

variable "policy_vars" {
  type = map(string)
  description = "Variables to populate policy document"
}

variable "role_vars" {
  type = map(string)
  description = "Variables to populate role document"
}


#####=============================Local Variables=====================#####
variable "component" {
  type        = string
  description = "Name for the component or project for with infra is provisioned"
}

variable "team" {
  type        = string
  description = "Project owner mailId / owner"
}

#####==============Local variables======================#####
locals {
  common_tags = {
    team        = var.team
    environment = var.environment
    component   = var.component
  }
}

