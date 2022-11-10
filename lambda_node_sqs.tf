data "archive_file" "lambda_python_sqs_archive" {
  source_dir  = "lambda/node/"
  output_path = "lambda/node/${local.app_name}-${var.lambda_name}.zip"
  type        = "zip"
}

resource "aws_lambda_function" "lambda_node_sqs" {
  function_name    = "${local.app_name}-${var.lambda_name}-node"
  handler          = "handler.lambda_handler"
  role             = aws_iam_role.lambda_role.arn
  runtime          = "nodejs16.x"

  filename         = data.archive_file.lambda_python_sqs_archive.output_path
  source_code_hash = data.archive_file.lambda_python_sqs_archive.output_base64sha256

  timeout          = 30
  memory_size      = 128
    
}

resource "aws_lambda_permission" "allows_sqs_to_trigger_node_lambda" {
  statement_id  = "AllowExecutionFromSQS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_node_sqs.function_name
  principal     = "sqs.amazonaws.com"
  source_arn    = aws_sqs_queue.raas-queue.arn
}

# Trigger lambda on message to SQS
resource "aws_lambda_event_source_mapping" "node_event_source_mapping" {
  batch_size       = 1
  event_source_arn =  aws_sqs_queue.raas-queue.arn
  enabled          = true
  function_name    =  aws_lambda_function.lambda_node_sqs.arn
}