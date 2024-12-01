resource "aws_acm_certificate" "dev_ssl_cert" {
  domain_name       = "dev.preyash.me"
  validation_method = "DNS"

  tags = {
    Environment = "dev"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "dev_ssl_cert_validation" {
  for_each = {
    for dvo in tolist(aws_acm_certificate.dev_ssl_cert.domain_validation_options) : dvo.domain_name => {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  }

  name    = each.value.name
  type    = each.value.type
  zone_id = var.DevZoneID
  records = [each.value.value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "dev_ssl_cert_validation" {
  certificate_arn         = aws_acm_certificate.dev_ssl_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.dev_ssl_cert_validation : record.fqdn]
}