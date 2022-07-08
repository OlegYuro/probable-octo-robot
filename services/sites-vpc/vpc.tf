module "aws_vpc_sites" {
  source = "../../modules/aws_vpc"

  name = "${var.environment}-${var.owners}-${var.service}"

  cidr                       = "${var.cidr}"
  public_subnets_cidr        = "${var.public_subnets_cidr}"
  private_subnets_cidr       = "${var.private_subnets_cidr}"

  use_internal_dhcp     = "${var.use_internal_dhcp}"

  tags = {
    terraform    = "true"
    location     = "aws"
    environment  = "${var.environment}"
    owner        = "${var.owners}"
    role         = "VPC"
    service      = "${var.service}"
  }
}

