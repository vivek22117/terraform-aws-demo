


provider "aws" {
  region  = "${var.default_region}"       //Interpolation syntax
  profile = "${var.profile}"

  version = "2.7.0"
}

