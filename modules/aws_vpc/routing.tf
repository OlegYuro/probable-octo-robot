resource "aws_route_table" "public_cidr" {
  vpc_id           = "${aws_vpc.vpc.id}"
  tags             = "${merge(var.tags, tomap({"Name" = format("%s-rt-public", var.name)}))}"
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public_cidr.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.igw.id}"
}

resource "aws_route_table_association" "public_cidr" {
  count          = "${length(var.public_subnets_cidr)}"
  subnet_id      = "${element(aws_subnet.public_cidr.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_cidr.id}"
}

