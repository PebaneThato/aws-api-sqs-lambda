resource "aws_api_gateway_rest_api" "raas-rest-api-tf" {
  name        = "raas-rest-api-tf"
  description = "Rest POST records to SQS queue"
}

resource "aws_api_gateway_resource" "send-client-data" {
    rest_api_id = aws_api_gateway_rest_api.raas-rest-api-tf.id
    parent_id   = aws_api_gateway_rest_api.raas-rest-api-tf.root_resource_id
    path_part   = "send-client-data"
}

resource "aws_api_gateway_request_validator" "validator_query" {
  name                        = "queryValidator"
  rest_api_id                 = aws_api_gateway_rest_api.raas-rest-api-tf.id
  validate_request_body       = false
  validate_request_parameters = true
}

resource "aws_api_gateway_method" "method_send-client-data" {
    rest_api_id   = aws_api_gateway_rest_api.raas-rest-api-tf.id
    resource_id   = aws_api_gateway_resource.send-client-data.id
    http_method   = "POST"
    authorization = "CUSTOM"
    authorizer_id = aws_api_gateway_authorizer.raas-rest-api-authorizer.id

    request_parameters = {
      "method.request.path.proxy"        = false
      "method.request.querystring.unity" = true
  }

  request_validator_id = aws_api_gateway_request_validator.validator_query.id
}
