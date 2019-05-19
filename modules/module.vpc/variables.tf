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

variable "bastion_instance" {
  type = "string"
  description = "Instance type for Bastion Instance"
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

variable "public_key" {
  type = "string"
  description = "key pair value"
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDV3fznjm92/s10goG0YotNIjq66CTDyf5a6wVVQUDYIF4OziH9G81NNc9sQiTlfNFy8RO4kSB0n5+w9nt90gs7nSZoBAATK6T0YNHll/A6ISUv4hgwooa6XUYxFgg+ceZ8Mvxc36wx78wTieVc7RTbx74Wr8AtavSJMC8wVb8QkUGMpumH7TNPP356MYEEgYciRLE8sLnkRYOvVekL3iU8p1tS5Pny5mqR1hinbQoE7WNuDsBxgV6Xn9kRQ9Rn5seIyY55tc1HPd2fwkafidWVX3hUD8RwOfSYvAwPc7AmVLCbUCktSZ8S1FEV9dSVncd8ji1tguoHh/OquXzNckqJ vivek@LAPTOP-FLDAPLLM"
}

//Local variables
locals {
  common_tags = {
    owner       = "${var.owner}"
    team        = "${var.team}"
    environment = "${var.environment}"
  }
}