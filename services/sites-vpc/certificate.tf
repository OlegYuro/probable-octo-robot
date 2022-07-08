resource "aws_acm_certificate" "test_cert" {
  domain_name       = "oleg-365scorestest.com"
  
  validation_method = "DNS"

  depends_on = [aws_route53_zone.primary]

  tags = {
    terraform    = "true"
    location     = "aws"
    environment  = "${var.environment}"
    owner        = "${var.owners}"
    role         = "${var.service}"
    service      = "${var.service}"
  }
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.test_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  name    = each.value.name
  type    = each.value.type
  zone_id = "${aws_route53_zone.primary.zone_id}"
  records = [each.value.record]
  ttl     = 60
}

#resource "aws_acm_certificate_validation" "cert" {
#  certificate_arn         = "${aws_acm_certificate.test_cert.arn}"
#  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
#  depends_on = [aws_acm_certificate.test_cert]
#}

#resource "aws_alb_listener_certificate" "list_certificate" {
#  depends_on      = ["aws_acm_certificate_validation.cert"]
#  listener_arn    = "${module.aws_alb_asg_lc_tg_ltg.listener_http_https_arn[0]}"  !!!!!!!!!!!
#  certificate_arn = "${aws_acm_certificate.test_cert.arn}"
#}
