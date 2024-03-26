
##########################################
# SNS Topic and it's subscription
##########################################

resource "aws_sns_topic" "root_activity_sns_topic" {

  name              = "${var.event_name}-topic"
  display_name      = var.display_name
  kms_master_key_id = "arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:alias/${var.sns_key_alias}"
  tags              =  { Name : "${var.event_name}-topic" }
}

resource "aws_sns_topic_subscription" "root_activity_sns_subscription" {
  for_each =  var.sns_subscription

  topic_arn = aws_sns_topic.root_activity_sns_topic.arn
  protocol  = "email"
  endpoint  = each.value.endpoint
}

##########################################
# Cloudwatch Event Rule and it's Target
##########################################

resource "aws_cloudwatch_event_rule" "root_activity_events_rule" {
  for_each =  var.event_patterns

  name          = "${var.event_name}-${each.key}-EventRule"
  description   = each.value.description
  event_pattern = each.value.event_pattern
  tags          = { Name : "${var.event_name}-event" }
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  for_each = var.event_patterns

  rule = aws_cloudwatch_event_rule.root_activity_events_rule[each.key].name
  arn  = aws_lambda_function.root_activity_lambda_function.arn
}

##########################################
# Lambda Function and it's permissions
##########################################

resource "aws_lambda_function" "root_activity_lambda_function" {

  filename      = var.lambda_filename
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  timeout       = var.lambda_timeout
  environment {
    variables = {
      sns_arn = aws_sns_topic.root_activity_sns_topic.arn
    }
  }

  tags = { Name : "${var.event_name}-function" }
}

resource "aws_lambda_permission" "primary_allow_events" {
  for_each =  var.event_patterns

  statement_id  = var.lambda_statement_id
  action        = var.lambda_action
  principal     = var.lambda_principal
  function_name = aws_lambda_function.root_activity_lambda_function.function_name
  source_arn    = aws_cloudwatch_event_rule.root_activity_events_rule[each.key].arn
}

##########################################
# Cloudwatch Log Groups
##########################################

resource "aws_cloudwatch_log_group" "primary_lambda_log_group" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = var.retention_in_days
  kms_key_id        = "arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:alias/${var.cloudwatch_key_alias}"

  tags = { Name : "${var.event_name}-loggroup" }
}
