resource "aws_subnet" "public_cidr" {
  count             = "${length(var.public_subnets_cidr)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.public_subnets_cidr[count.index]}"
  availability_zone = "${element(data.aws_availability_zones.all.names, count.index)}"
  tags              = "${merge(var.tags, var.public_subnet_tags, tomap({"Name" = format("%s-subnet-public-%s", var.name, substr(element(data.aws_availability_zones.all.names, count.index), -2,-1) )}))}"

  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
}

resource "aws_subnet" "private_cidr" {
  count             = "${length(var.private_subnets_cidr)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.private_subnets_cidr[count.index]}"
  availability_zone = "${element(data.aws_availability_zones.all.names, count.index)}"
  tags              = "${merge(var.tags, var.private_subnet_tags, tomap({"Name" = format("%s-subnet-private-%s", var.name, substr(element(data.aws_availability_zones.all.names, count.index), -2,-1) )}))}"
}

