resource "aws_api_gateway_authorizer" "raas-rest-api-authorizer" {
  name                   = "raas-rest-api-authorizer"
  rest_api_id            = aws_api_gateway_rest_api.raas-rest-api-tf.id
  authorizer_uri         = aws_lambda_function.lambda_python_authorizer.invoke_arn
  authorizer_credentials = aws_iam_role.apiSQS.arn
}

resource "aws_iam_role_policy" "invocation_policy" {
  name = "default"
  role = aws_iam_role.apiSQS.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "lambda:InvokeFunction",
      "Effect": "Allow",
      "Resource": "${aws_lambda_function.lambda_python_authorizer.arn}"
    }
  ]
}
EOF
}