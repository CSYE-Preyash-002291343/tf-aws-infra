resource "aws_route53_record" "a_record" {
  zone_id = var.ZoneID
  name    = "${var.environment}.${var.domain}"
  type    = "A"
  alias {
    name                   = aws_lb.webapp_alb.dns_name
    zone_id                = aws_lb.webapp_alb.zone_id
    evaluate_target_health = true
  }
}
