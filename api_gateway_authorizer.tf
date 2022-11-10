resource "aws_api_gateway_authorizer" "raas-rest-api-authorizer" {
  name                   = "raas-rest-api-authorizer"
  rest_api_id            = aws_api_gateway_rest_api.raas-rest-api-tf.id
  authorizer_uri         = aws_lambda_function.lambda_python_authorizer.invoke_arn
  authorizer_credentials = aws_iam_role.invocation_role.arn
}