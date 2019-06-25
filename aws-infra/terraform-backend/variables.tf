//Global Variables
variable "profile" {
  type        = "string"
  description = "AWS Profile name for credentials"
}

variable "create_env" {
  type        = "string"
  description = "Number of environment to create for deployment"
}

//Default Variables
variable "s3_bucket_prefix" {
  type        = "string"
  default     = "teamconcept-tfstate"
  description = "Prefix for s3 bucket"
}

variable "dyanamoDB_prefix" {
  type        = "string"
  default     = "teamconcept-tfstate"
  description = "Pefix for dynamoDB Table"
}

variable "artifactory_bucket_prefix" {
  type        = "string"
  description = "Prefind for Artifactory Bucket"
  default     = "teamconcept-deploy"
}

variable "default_region" {
  type    = "string"
  default = "us-east-1"
}

variable "environment_list" {
  type    = "list"
  default = ["dev", "prod", "shared"]
}

//Local variables
locals {
  common_tags = {
    owner = "Vivek"
    team  = "TeamConcept"
  }
}
