resource "aws_lambda_function" "EmailVerificationFunction" {
  filename      = "D:/Semester - 3/CSYE 6225 - Assignments/lambdafunction.zip" # Package containing your Lambda code
  function_name = "EmailVerificationFunction"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "index.handler"
  runtime       = "nodejs20.x"

  environment {
    variables = {
      SENDGRID_API_KEY    = var.SENDGRID_API_KEY
      APP_BASE_URL        = var.APP_BASE_URL
      SENDGRID_FROM_EMAIL = var.SENDGRID_FROM_EMAIL
    }
  }
}
