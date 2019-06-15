resource "aws_route" "public" {
  route_table_id = "${var.public_route_tb_id}"
  destination_cidr_block = "${var.peer_cidr}"
  vpc_peering_connection_id = "${var.peering_connection_id}"
}

resource "aws_route" "private" {
  count = "${length(var.private_route_tb_ids)}"
  route_table_id = "${var.private_route_tb_ids[count.index]}"
  destination_cidr_block = "${var.peer_cidr}"
  vpc_peering_connection_id = "${var.peering_connection_id}"
}