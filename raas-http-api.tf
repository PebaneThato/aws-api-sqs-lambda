resource "aws_apigatewayv2_api" "raas-http-api-tf" {
  name          = "raas-http-api-tf"
  description = "Http POST records to SQS queue"
  protocol_type = "HTTP"
}
