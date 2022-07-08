resource "aws_vpc" "vpc" {
  cidr_block           = "${var.cidr}"
  instance_tenancy     = "${var.instance_tenancy}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"
  tags                 = "${merge(var.tags, tomap({"Name" = format("%s", var.name)}))}"
}

resource "aws_default_network_acl" "default" {
  default_network_acl_id = "${aws_vpc.vpc.default_network_acl_id}"
  tags                   = "${merge(var.tags, tomap({"Name" = format("%s-acl-default", var.name)}))}"

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  lifecycle {
    ignore_changes = [default_network_acl_id, ingress, egress, subnet_ids]
  }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = "${aws_vpc.vpc.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.internal.id}"
  depends_on      = [aws_subnet.public_cidr, aws_subnet.private_cidr]
}

resource "aws_vpc_dhcp_options" "internal" {
  domain_name          = "${var.tags["environment"]}-aws.local"
  domain_name_servers  = "${var.dns_servers}"
  ntp_servers          = "${var.ntp_servers}"

  tags   = "${merge(var.tags, tomap({"Name" = format("%s-aws.local-dhcp", var.tags["environment"])}))}"
}