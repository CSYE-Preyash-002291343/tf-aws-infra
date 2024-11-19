resource "aws_sns_topic" "userUpdate" {
  name = "userUpdate"
}

# Add a SNS suscription to lambda function
resource "aws_sns_topic_subscription" "lambda" {
  topic_arn = aws_sns_topic.userUpdate.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.EmailVerificationFunction.arn
}

# Allow SNS to invoke the lambda function
resource "aws_lambda_permission" "allowSNS" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.EmailVerificationFunction.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.userUpdate.arn

}