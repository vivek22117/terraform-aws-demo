output "vpc_peering_connection" {
  value = "${aws_vpc_peering_connection.dev-prod.id}"
}