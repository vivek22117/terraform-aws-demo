output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnets" {
  value = aws_subnet.public.*.id
}

output "public_cidrs" {
  value = aws_subnet.public.*.cidr_block
}

output "private_subnets" {
  value = aws_subnet.private.*.id
}

output "private_cirds" {
  value = aws_subnet.private.*.cidr_block
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_host_sg.id
}

output "vpc_cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

