#### VPC TF Outputs ######
# VPC #
output vpc_id {
  value = "${module.aws_vpc_sites.vpc_id}"
}

output vpc_cidr_block {
  value = "${module.aws_vpc_sites.vpc_cidr_block}"
}

# Subnets #
output "public_subnets" {
  value = "${module.aws_vpc_sites.public_subnets}"
}

output "private_subnets" {
  value = "${module.aws_vpc_sites.private_subnets}"
}

# Endpoints and Gateways #
output "igw_id" {
  value = "${module.aws_vpc_sites.igw_id}"
}

# Routing #
output "public_route_table_ids" {
  value = "${module.aws_vpc_sites.public_route_table_ids}"
}

# Security Groups #
output "sg_id" {
  value = "${module.aws_vpc_sites.sg_id}"
}

output "common_sg_ids" {
  value = "${module.aws_vpc_sites.common_sg_ids}"
}

output "common_sg_names" {
  value = "${module.aws_vpc_sites.common_sg_names}"
}
