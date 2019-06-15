resource "aws_vpc_peering_connection" "dev-prod" {
  vpc_id = "${var.requester_vpc_id}"
  peer_vpc_id = "${var.accepter_vpc_id}"
  auto_accept = true

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  accepter {
    allow_remote_vpc_dns_resolution = true
  }
}