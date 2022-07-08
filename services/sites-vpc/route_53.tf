resource "aws_route53_zone" "primary" {
  name = "${var.cert_domain}"

  tags = {
    terraform    = "true"
    location     = "aws"
    environment  = "${var.environment}"
    owner        = "${var.owners}"
    role         = "${var.service}"
    service      = "${var.service}"
  }
}

resource "aws_route53_record" "primary-caa" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "${var.cert_domain}"
  type    = "CAA"
  ttl     = "900"

  records = [
    "0 issue \"awstrust.com\"",
    "0 issuewild \"amazontrust.com\"",
    "0 issue \"amazontrust.com\"",
    "0 issuewild \"amazonaws.com\"",
    "0 issuewild \"awstrust.com\"",
    "0 issuewild \"amazon.com\"",
    "0 issue \"amazonaws.com\"",
    "0 issue \"amazon.com\"",
    "0 issue \"globalsign.com\"",
    "0 issuewild \"globalsign.com\""
  ]
}

resource "aws_route53_record" "test_record" {

  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "${var.cert_domain}"
  type    = "A"

  alias {
    name                   = "${aws_lb.alb.dns_name}"
    zone_id                = "${aws_lb.alb.zone_id}"
    evaluate_target_health = false
  }

}

