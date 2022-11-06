resource "aws_apigatewayv2_api" "raas-http-api-tf" {
  name          = "raas-http-api-tf"
  protocol_type = "HTTP"
}
