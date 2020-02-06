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

variable "role_name" {
  type        = string
  description = "Name of the IAM role"
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
    team        = "DoubleDigitTeam"
    environment = var.environment
    component   = var.component
  }
}

