resource "aws_iam_role" "apiSQS" {
  name = "apigateway_sqs"

  assume_role_policy = {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "apigateway.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
}

data "template_file" "gateway_policy" {
  template = file("policies/api-gateway-permission.json")

  vars = {
    sqs_arn   = aws_sqs_queue.queue.arn
  }
}

resource "aws_iam_policy" "api_policy" {
  name = "api-sqs-cloudwatch-policy"

  policy = data.template_file.gateway_policy.rendered
}


resource "aws_iam_role_policy_attachment" "api_exec_role" {
  role       =  aws_iam_role.apiSQS.name
  policy_arn =  aws_iam_policy.api_policy.arn
}
