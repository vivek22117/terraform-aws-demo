variable "public_route_tb_id" {
  type = "string"
  description = "Public route table Id"
}

variable "private_route_tb_ids" {
  type = "list"
  description = "Private route table Id"
}

variable "peer_cidr" {
  type = "string"
  description = "CIDR of vpc peering connection"
}

variable "peering_connection_id" {
  type = "string"
  description = "Connection id of peeering VPC"
}

variable "requester_vpc_id" {
  type = "string"
  description = "Requester VPC id"
}

variable "accepter_vpc_id" {
  type = "string"
  description = "Accepter VPC id"
}