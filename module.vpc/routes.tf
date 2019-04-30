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

  tags {
    Name  = "Public_route_${aws_vpc.dev_vpc.id}"
    owner = "${var.owner}"
  }
}

######################################################
# Create a new route table for private subnets
# Route non-local traffic through the NAT gateway
# to the Internet
######################################################
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.dev_vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gateway.id}"
  }

  tags {
    Name  = "Private_route_${aws_vpc.dev_vpc.id}"
    owner = "${var.owner}"
  }
}

resource "aws_route_table_association" "public_association" {
  count = "${length(var.available_zones)}"

  route_table_id = "${aws_route_table.public.id}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
}

resource "aws_route_table_association" "private_association" {
  count = "${length(var.available_zones)}"

  route_table_id = "${aws_route_table.private.id}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
}
