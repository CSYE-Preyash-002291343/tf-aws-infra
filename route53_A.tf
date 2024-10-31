resource "aws_route53_record" "a_record" {
  zone_id = var.ZoneID
  name    = "${var.environment}.${var.domain}"
  type    = "A"
  ttl     = 60
  records = [aws_instance.app.public_ip]
}
