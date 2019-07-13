//Global Variables
variable "profile" {
  type        = string
  description = "AWS Profile name for credentials"
}


//Default Variables
variable "s3_bucket_prefix" {
  type        = string
  default     = "teamconcept-tfstate"
  description = "Prefix for s3 bucket"
}

variable "dyanamoDB_prefix" {
  type        = string
  default     = "teamconcept-tfstate"
  description = "Pefix for dynamoDB Table"
}

variable "artifactory_bucket_prefix" {
  type        = string
  description = "Prefind for Artifactory Bucket"
  default     = "teamconcept-deploy"
}

variable "default_region" {
  type    = string
  default = "us-east-1"
}

variable "environment" {
  type    = string
  default = "prod"
}

//Local variables
locals {
  common_tags = {
    owner = "Vivek"
    team  = "TeamConcept"
  }
}

