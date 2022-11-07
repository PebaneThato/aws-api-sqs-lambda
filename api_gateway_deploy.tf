resource "aws_api_gateway_deployment" "api" {
 rest_api_id = aws_api_gateway_rest_api.raas-rest-api-tf.id
 stage_name  = var.environment

 depends_on = [
   aws_api_gateway_integration.api,
 ]

 lifecycle {
   create_before_destroy = true
 }
}
