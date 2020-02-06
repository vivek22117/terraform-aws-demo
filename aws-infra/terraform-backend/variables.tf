#####===================Global Variables====================#####
variable "profile" {
  type        = string
  description = "AWS Profile name for credentials"
}

variable "default_region" {
  type    = string
  description = "AWS region to provision"
}

variable "environment" {
  type    = string
  description = "Development environment"
}

#####==================BackendConfig Variables====================#####
variable "tf_s3_bucket_prefix" {
  type        = string
  description = "Prefix for s3 bucket"
}

variable "dyanamoDB_prefix" {
  type        = string
  description = "Pefix for dynamoDB Table"
}

variable "artifactory_bucket_prefix" {
  type        = string
  description = "Prefind for Artifactory Bucket"
}

variable "dataLake_bucket_prefix" {
  type        = string
  description = "Bucket to store data"
}


#####=============================Local Variables=====================#####
variable "component" {
  type = string
  description = "Name for the component or project for with infra is provisioned"
}

variable "team" {
  type = string
  description = "Project owner mailId / owner"
}

#####==============Local variables======================#####
locals {
  common_tags = {
    team  = "DoubleDigitTeam"
    environment = var.environment
    component = var.component
  }
}

