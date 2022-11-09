data "archive_file" "lambda_with_dependencies" {
  source_dir  = "lambda/python/"
  output_path = "lambda/python/${local.app_name}-${var.lambda_name}.zip"
  type        = "zip"
}

resource "aws_lambda_function" "lambda_python_sqs" {
  function_name    = "${local.app_name}-${var.lambda_name}"
  handler          = "handler.lambda_handler"
  role             = aws_iam_role.lambda_role.arn
  runtime          = "python3.7"

  filename         = data.archive_file.lambda_with_dependencies.output_path
  source_code_hash = data.archive_file.lambda_with_dependencies.output_base64sha256

  timeout          = 30
  memory_size      = 128

}
