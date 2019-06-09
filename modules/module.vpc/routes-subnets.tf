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
  count = "${var.enable_nat_gateway == true ? length(var.available_zones) : 0}"

  tags {
    Name = "EIP_${var.environment}_${aws_vpc.dev_vpc.id}_${count.index}"
  }
}

//Create NatGateway and allocate EIP
resource "aws_nat_gateway" "nat_gateway" {
  depends_on = ["aws_internet_gateway.vpc_igw"]
  count = "${var.enable_nat_gateway == true ? length(var.available_zones) : 0}"

  allocation_id = "${element(aws_eip.nat_eip.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"

  tags {
    Name = "NAT_${var.environment}_${aws_vpc.dev_vpc.id}_${count.index}"
  }
}

######################################################
# Create route table for private subnets
# Route non-local traffic through the NAT gateway
# to the Internet
######################################################
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.dev_vpc.id}"
  count = "${length(var.available_zones)}"

  tags = "${merge(local.common_tags, map("Name", "Private_route_${var.environment}_${aws_vpc.dev_vpc.id}_${count.index}"))}"
}

resource "aws_route" "private_nat_gateway" {
  count = "${var.enable_nat_gateway == true ? length(var.available_zones) : 0}"

  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${element(aws_nat_gateway.nat_gateway.*.id, count.index)}"
}

resource "aws_route_table_association" "private_association" {
  count = "${length(var.available_zones)}"

  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
}

######################################################
# Route the public subnet traffic through
# the Internet Gateway
######################################################
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.dev_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc_igw.id}"
  }

  tags = "${merge(local.common_tags, map("Name", "Public_route_${var.environment}_${aws_vpc.dev_vpc.id}"))}"
}

resource "aws_route_table_association" "public_association" {
  count = "${length(var.available_zones)}"

  route_table_id = "${aws_route_table.public.id}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
}

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

  tags = "${merge(local.common_tags, map("Name", "PublicSubnet-${var.environment}-${element(var.available_zones, count.index)}"))}"
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

  tags = "${merge(local.common_tags, map("Name", "PrivateSubnet-${var.environment}-${element(var.available_zones, count.index)}"))}"
}


