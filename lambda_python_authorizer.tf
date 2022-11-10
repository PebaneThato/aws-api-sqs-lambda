data "archive_file" "lambda_python_authorizer_archive" {
  source_dir  = "lambda/python/authorizer/"
  output_path = "lambda/python/authorizer/${local.app_name}-${var.lambda_name}.zip"
  type        = "zip"
}

resource "aws_lambda_function" "lambda_python_authorizer" {
  function_name    = "${local.app_name}-${var.lambda_name}-python-authorizer"
  handler          = "authorizer.lambda_handler"
  role             = aws_iam_role.lambda_role.arn
  runtime          = "python3.7"

  filename         = data.archive_file.lambda_python_authorizer_archive.output_path
  source_code_hash = data.archive_file.lambda_python_authorizer_archive.output_base64sha256

  timeout          = 30
  memory_size      = 128

}