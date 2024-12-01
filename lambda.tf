resource "aws_lambda_function" "EmailVerificationFunction" {
  filename      = "D:/Semester - 3/CSYE 6225 - Assignments/Lambda.zip" # Package containing your Lambda code
  function_name = "EmailVerificationFunction"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "index.handler"
  runtime       = "nodejs20.x"

  environment {
    variables = {
      APP_BASE_URL = var.APP_BASE_URL
      emailCreds   = var.emailCreds
    }
  }
}
