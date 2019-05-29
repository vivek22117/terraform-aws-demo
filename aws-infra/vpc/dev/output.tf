output "vpc_id" {
  value = "${module.vpc-dev.vpc_id}"
}

output "private_subnets" {
  value = "${module.vpc-dev.private_subnets}"
}

output "public_subnets" {
  value = "${module.vpc-dev.public_subnets}"
}

output "bastion_sg" {
  value = "${module.vpc-dev.bastion_sg_id}"
}

output "s3_bucket_name" {
  value = "${module.vpc-dev.s3_deploy_bucket}"
}

output "s3_bucket_arn" {
  value = "${module.vpc-dev.s3_deploy_arn}"
}