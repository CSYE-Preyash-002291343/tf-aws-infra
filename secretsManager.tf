resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "#$%&*()-_=+"
  min_special      = 2
  min_upper        = 2
  min_lower        = 2
  min_numeric      = 2
}

resource "aws_secretsmanager_secret" "random_password" {
  name       = var.rdsCreds
  kms_key_id = aws_kms_key.secrets_key.arn
}

resource "aws_secretsmanager_secret_version" "random_password" {
  secret_id = aws_secretsmanager_secret.random_password.id
  secret_string = jsonencode({
    password = random_password.db_password.result
  })
}

resource "aws_secretsmanager_secret" "emailCreds" {
  name       = var.emailCreds
  kms_key_id = aws_kms_key.secrets_key.arn
}

resource "aws_secretsmanager_secret_version" "emailCreds" {
  secret_id = aws_secretsmanager_secret.emailCreds.id
  secret_string = jsonencode({
    SENDGRID_FROM_EMAIL = var.SENDGRID_FROM_EMAIL,
    SENDGRID_API_KEY    = var.SENDGRID_API_KEY
  })
}