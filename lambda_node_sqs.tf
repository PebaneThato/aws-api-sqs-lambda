data "archive_file" "node_lambda_archive" {
  source_dir  = "lambda/node/"
  output_path = "lambda/node/${local.app_name}-${var.lambda_name}.zip"
  type        = "zip"
}

resource "aws_lambda_function" "results_updates_lambda" {
  function_name    = "${local.app_name}-${var.lambda_name}"
  handler          = "handler.lambda_handler"
  role             = aws_iam_role.lambda_role.arn
  runtime          = "nodejs12.x"

  filename         = data.archive_file.node_lambda_archive.output_path
  source_code_hash = data.archive_file.node_lambda_archive.output_base64sha256

  timeout          = 30
  memory_size      = 128
    
}