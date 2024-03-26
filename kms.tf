resource "aws_kms_key" "sns_key" {
  tags                = { Name : "${var.event_name}-topic" }
  enable_key_rotation = true
  deletion_window_in_days = var.deletion_key_window_in_days
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Id": "sns-key-policy",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow access for Key Administrators",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "sns.amazonaws.com"
            },
            "Action": [
                "kms:Encrypt*",
                "kms:Decrypt*",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:Describe*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_kms_key" "cloudwatch_kms_key" {
  description         = "KMS key for CloudWatch Logs encryption"
  enable_key_rotation = true
  deletion_window_in_days = var.deletion_key_window_in_days
  policy              = <<EOF
{
    "Version": "2012-10-17",
    "Id": "cloudwatch-key-policy",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow access for Key Administrators",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "kms:*",
            "Resource": "*",
            "Condition": {
                "ArnEquals": {
                    "kms:EncryptionContext:aws:logs:arn": "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:*"
                }
            }
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "logs.us-east-1.amazonaws.com"
            },
            "Action": [
                "kms:Encrypt*",
                "kms:Decrypt*",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:Describe*"
            ],
            "Resource": "*",
            "Condition": {
                "ArnLike": {
                    "kms:EncryptionContext:aws:logs:arn": "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:*"
                }
            }
        }
    ]
}
EOF
}




