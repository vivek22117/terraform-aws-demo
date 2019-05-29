output "vpc_id" {
  value = "${aws_vpc.dev_vpc.id}"
}

output "public_subnets" {
  value = "${aws_subnet.public.*.id}"
}

output "public_cidrs" {
  value = "${aws_subnet.public.*.cidr_block}"
}

output "private_subnets" {
  value = "${aws_subnet.private.*.id}"
}

output "private_cirds" {
  value = "${aws_subnet.private.*.cidr_block}"
}

output "bastion_sg_id" {
  value = "${aws_security_group.bastion_host_sg.id}"
}

output "s3_deploy_bucket" {
  value = "${aws_s3_bucket.s3_deploy_bucket.id}"
}

output "s3_deploy_arn" {
  value = "${aws_s3_bucket.s3_deploy_bucket.arn}"
}
