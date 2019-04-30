output "vpc_id" {
  value = "${module.vpc_one.vpc_id}"
}

output "public_subnets" {
  value = "${module.vpc_one.public_subnets}"
}

output "public_cidrs" {
  value = "${module.vpc_one.public_cidrs}"
}

output "private_subnets" {
  value = "${module.vpc_one.private_subnets}"
}

output "private_cirds" {
  value = "${module.vpc_one.private_cirds}"
}
