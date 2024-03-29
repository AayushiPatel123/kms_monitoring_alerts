<!-- BEGIN_TF_DOCS -->
## Architectural Diagram
![Diagram](https://https://github.com/AayushiPatel123/kms_monitoring_alerts/main/Images/Architecture_Diagram.jpg "Diagram")



## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.4.2 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.76.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.root_activity_events_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.lambda_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_log_group.primary_lambda_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.lambda_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.lambda_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_key.cloudwatch_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.sns_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_lambda_function.root_activity_lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.primary_allow_events](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_sns_topic.root_activity_sns_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.root_activity_sns_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [archive_file.lambda_package](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_key_alias"></a> [cloudwatch\_key\_alias](#input\_cloudwatch\_key\_alias) | alias of the KMS Key for encrypting Cloudwatch logs. | `string` | `"cloudwatch-logs-key"` | no |
| <a name="input_deletion_key_window_in_days"></a> [deletion\_key\_window\_in\_days](#input\_deletion\_key\_window\_in\_days) | The waiting period, specified in number of days. | `number` | `7` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name for the topic | `string` | `""` | no |
| <a name="input_event_name"></a> [event\_name](#input\_event\_name) | Name of the Cloudwatch Event | `string` | `""` | no |
| <a name="input_event_patterns"></a> [event\_patterns](#input\_event\_patterns) | Map of event patterns for CloudWatch events | <pre>map(object({<br>    description   = string<br>    event_pattern = string<br>  }))</pre> | `null` | no |
| <a name="input_lambda_action"></a> [lambda\_action](#input\_lambda\_action) | The AWS Lambda action you want to allow in this statement. | `string` | `"lambda:InvokeFunction"` | no |
| <a name="input_lambda_filename"></a> [lambda\_filename](#input\_lambda\_filename) | Path to the function's deployment package within the local filesystem | `string` | `""` | no |
| <a name="input_lambda_function_name"></a> [lambda\_function\_name](#input\_lambda\_function\_name) | Unique name for your Lambda Function | `string` | `""` | no |
| <a name="input_lambda_handler"></a> [lambda\_handler](#input\_lambda\_handler) | Function entrypoint in your code | `string` | `"RootActivityLambda.lambda_handler"` | no |
| <a name="input_lambda_principal"></a> [lambda\_principal](#input\_lambda\_principal) | The principal who is getting this permission. | `string` | `"events.amazonaws.com"` | no |
| <a name="input_lambda_runtime"></a> [lambda\_runtime](#input\_lambda\_runtime) | Identifier of the function's runtime. See Runtimes for valid values | `string` | `"python3.8"` | no |
| <a name="input_lambda_statement_id"></a> [lambda\_statement\_id](#input\_lambda\_statement\_id) | A unique statement identifier. By default generated by Terraform | `string` | `"AllowExecutionFromCloudWatch"` | no |
| <a name="input_lambda_timeout"></a> [lambda\_timeout](#input\_lambda\_timeout) | Amount of time your Lambda Function has to run in seconds. | `number` | `60` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | Specifies the number of days you want to retain log events in the specified log group. | `number` | `30` | no |
| <a name="input_sns_key_alias"></a> [sns\_key\_alias](#input\_sns\_key\_alias) | alias of the KMS Key for encrypting SNS. | `string` | `"sns-key"` | no |
| <a name="input_sns_subscription"></a> [sns\_subscription](#input\_sns\_subscription) | Map of SNS subscriptions, keyed by endpoint. | <pre>map(object({<br>    endpoint = string<br>  }))</pre> | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->