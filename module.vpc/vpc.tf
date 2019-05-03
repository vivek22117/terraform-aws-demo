resource "aws_vpc" "dev_vpc" {
  cidr_block           = "${var.cidr_block}"
  enable_dns_hostnames = true

  tags {
    Name  = "VPC_${var.environment}_${var.cidr_block}"
    owner = "${var.owner}"
  }
}

######################################################
# Enable access to or from the Internet for instances
# in public subnets
######################################################
resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = "${aws_vpc.dev_vpc.id}"

  tags {
    Name = "IGW-${var.environment}"
  }
}
