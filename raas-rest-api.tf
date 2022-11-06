resource "aws_api_gateway_rest_api" "raas-rest-api-tf" {
  name        = "api-gateway-SQS"
  description = "POST records to SQS queue"
}

resource "aws_api_gateway_resource" "form_score" {
    rest_api_id = aws_api_gateway_rest_api.raas-rest-api-tf.id
    parent_id   = aws_api_gateway_rest_api.raas-rest-api-tf.root_resource_id
    path_part   = "form-score"
}

resource "aws_api_gateway_request_validator" "validator_query" {
  name                        = "queryValidator"
  rest_api_id                 = aws_api_gateway_rest_api.raas-rest-api-tf.id
  validate_request_body       = false
  validate_request_parameters = true
}

resource "aws_api_gateway_method" "method_form_score" {
    rest_api_id   = aws_api_gateway_rest_api.raas-rest-api-tf.id
    resource_id   = aws_api_gateway_resource.form_score.id
    http_method   = "POST"
    authorization = "NONE"

    request_parameters = {
      "method.request.path.proxy"        = false
      "method.request.querystring.unity" = true
  }

  request_validator_id = aws_api_gateway_request_validator.validator_query.id
}
