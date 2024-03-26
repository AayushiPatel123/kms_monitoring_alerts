event_name  = "kms_monitoring"
display_name = "kms_monitoring"
sns_subscription = {
    "aayushi" = {
        endpoint = "aayushipatel1916@gmail.com"
    },
    "manish" =  {
        endpoint = "alvinmanish234@gmail.com"
    },
}
event_patterns = {
    "kms_key" =  {
        description = "alerts for kms encrypt, decrypt"
        event_pattern = <<-EOF
      {
        "source": ["aws.kms"],
        "detail-type": ["AWS API Call via CloudTrail"],
        "detail": {
          "eventName": ["Encrypt", "Decrypt"],
          "eventSource": ["kms.amazonaws.com"],
          "resources": "*",
          "userIdentity": {
            "type": ["IAMUser", "AssumedRole"]
          }
        }
      }
      EOF
    }
}

lambda_function_name= "monitoring_alert"
lambda_filename = "LamdaAlert"
lambda_handler = "LamdaAlert.lambda_handler"