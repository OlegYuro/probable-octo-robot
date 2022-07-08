resource "aws_lb" "alb" {
  name            = "${var.environment}-alb"
  internal        = false
  subnets         = flatten([module.aws_vpc_sites.public_subnets])
  idle_timeout    = "${var.idle_timeout}"
  load_balancer_type  = "${var.load_balancer_type}"

  security_groups = [for sg in module.aws_vpc_sites.common_sg_ids : sg]
  enable_deletion_protection = false

  depends_on      = [module.aws_vpc_sites, aws_acm_certificate.test_cert]

  tags = {
    terraform    = true 
    location     = "aws"
    environment  = "${var.environment}"
    owner        = "${var.owners}"
    role         = "ltg"
    service      = "${var.service}"
    encrypted    = "true"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content. Port 80"
      status_code  = "200"
    }
  }
}

#resource "aws_lb_listener" "https" {
#  load_balancer_arn = "${aws_lb.alb.arn}"
#  port              = "443"
#  protocol          = "HTTPS"
#  ssl_policy        = "ELBSecurityPolicy-2016-08"
#  certificate_arn   = "${aws_acm_certificate.test_cert.arn}"
#
#  default_action {
#    type = "fixed-response"
#
#    fixed_response {
#      content_type = "text/plain"
#      message_body = "Fixed response content. Port 443"
#      status_code  = "200"
#    }
#  }
#}
