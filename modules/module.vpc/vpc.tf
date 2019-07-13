resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.support_dns


  tags = merge(local.common_tags, map("Name", "VPC_${var.environment}_${var.cidr_block}"))
}

######################################################
# Enable access to or from the Internet for instances
# in public subnets
######################################################
resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(local.common_tags, map("Name", "IGW-${var.environment}"))
}

