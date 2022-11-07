# Mapping SQS Response
resource "aws_api_gateway_method_response" "http200" {
 rest_api_id = aws_api_gateway_rest_api.raas-rest-api-tf.id
 resource_id = aws_api_gateway_resource.form_score.id
 http_method = aws_api_gateway_method.method_form_score.http_method
 status_code = 200
}

resource "aws_api_gateway_integration_response" "http200" {
 rest_api_id       = aws_api_gateway_rest_api.raas-rest-api-tf.id
 resource_id       = aws_api_gateway_resource.form_score.id
 http_method       = aws_api_gateway_method.method_form_score.http_method
 status_code       = aws_api_gateway_method_response.http200.status_code
 selection_pattern = "^2[0-9][0-9]"                                       // regex pattern for any 200 message that comes back from SQS

 depends_on = [
   aws_api_gateway_integration.api
   ]
}
