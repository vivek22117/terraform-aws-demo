output "vpc_id" {
  value = "${module.vpc-dev.vpc_id}"
}

output "private_subnets" {
  value = "${module.vpc-dev.private_subnets}"
}

output "public_subnets" {
  value = "${module.vpc-dev.public_subnets}"
}