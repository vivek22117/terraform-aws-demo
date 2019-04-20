resource "aws_vpc" "dev_vpc" {
  cidr_block = "${var.cidr_block}"

  tags {
    Name = "VPC_${var.environment}"
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
