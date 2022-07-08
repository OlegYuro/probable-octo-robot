##### VPC #####
output vpc_id {
  value = "${aws_vpc.vpc.id}"
}

output vpc_cidr_block {
  value = "${aws_vpc.vpc.cidr_block}"
}

##### Subnets #####
output "public_subnets" {
  value = ["${aws_subnet.public_cidr.*.id}"]
}

output "private_subnets" {
  value = ["${aws_subnet.private_cidr.*.id}"]
}

##### Endpoints and Gateways #####
output "igw_id" {
  value = "${aws_internet_gateway.igw.id}"
}


##### Routing #####
output "public_route_table_ids" {
  value = ["${aws_route_table.public_cidr.*.id}"]
}


##### Security Groups #####
output "sg_id" {
  value = "${aws_security_group.sg.id}"
}

output "common_sg_ids" {
  value = ["${aws_security_group.sg.id}"]
}

output "common_sg_names" {
  value = ["${aws_security_group.sg.name}"]
}
