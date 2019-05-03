######################################################
# Public subnets
# Each subnet in a different AZ
######################################################
resource "aws_subnet" "public" {
  count                   = "${length(var.available_zones)}"
  cidr_block              = "10.0.${count.index * 2 +1}.0/24"
  vpc_id                  = "${aws_vpc.dev_vpc.id}"
  availability_zone       = "${element(var.available_zones, count.index)}"
  map_public_ip_on_launch = true

  tags = "${merge(local.common_tags, map("Name", "PublicSubnet-${element(var.available_zones, count.index)}"))}"
}

######################################################
# Private subnets
# Each subnet in a different AZ
######################################################
resource "aws_subnet" "private" {
  count                   = "${length(var.available_zones)}"
  cidr_block              = "10.0.${count.index * 2}.0/24"
  vpc_id                  = "${aws_vpc.dev_vpc.id}"
  availability_zone       = "${element(var.available_zones,count.index)}"
  map_public_ip_on_launch = false

  tags = "${merge(local.common_tags, map("Name", "PrivateSubnet-${element(var.available_zones, count.index)}"))}"
}

######################################################
# NAT gateways  enable instances in a private subnet
# to connect to the Internet or other AWS services,
# but prevent the internet from initiating
# a connection with those instances.
#
# Each NAT gateway requires an Elastic IP.
######################################################
resource "aws_eip" "nat_eip" {
  vpc = true

  tags {
    Name = "EIP_${aws_vpc.dev_vpc.id}"
  }
}

//Create NatGateway and allocate EIP
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id     = "${element(aws_subnet.public.*.id, 0)}"

  tags {
    Name = "NAT_${aws_vpc.dev_vpc.id}"
  }
}
