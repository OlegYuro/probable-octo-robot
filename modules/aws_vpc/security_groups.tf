resource "aws_default_security_group" "default" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags   = "${merge(var.tags, tomap({"Name" = format("%s-sg-default", var.name)}))}"

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "sg" {
  name        = "${var.name}-sg"
  vpc_id      = "${aws_vpc.vpc.id}"
  description = "Allow 80 and 443"
  tags        = "${merge(var.tags, tomap({"Name" = format("%s-sg", var.name)}))}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "cidr_sg_80" {
  type        = "ingress"
  protocol    = "tcp"
  cidr_blocks = ["${var.cidr}"]
  from_port   = "80"
  to_port     = "80"
  description = "VPC"

  security_group_id = "${aws_security_group.sg.id}"
}

resource "aws_security_group_rule" "cidr_sg_443" {
  type        = "ingress"
  protocol    = "tcp"
  cidr_blocks = ["${var.cidr}"]
  from_port   = "443"
  to_port     = "443"
  description = "VPC"

  security_group_id = "${aws_security_group.sg.id}"
}
