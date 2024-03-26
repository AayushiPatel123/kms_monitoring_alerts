data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "archive_file" "lambda_package" {
  type        = "zip"
  source_file = "./LambdaAlert.py"
  output_path = "LambdaAlert.zip"
}