provider "aws" {
  region              = "${var.aws_region}"
  allowed_account_ids = ["${var.aws_account_id}"]
}

terraform {
  backend "local" {}
}

data "aws_availability_zones" "all" {}

