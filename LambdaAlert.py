import json
import boto3
import logging
import os
from botocore.exceptions import ClientError

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def lambda_handler(event, context):
    # Adjust logging level as needed (optional)
    logger.setLevel(logging.INFO)

    # Extract event details
    event_name = event['detail']['eventName']
    sns_arn = os.environ['sns_arn']  # SNS Topic ARN from environment variables
    key_id = event['detail'].get('requestParameters', {}).get('keyId', 'N/A')  # Default to 'N/A' if not present
    account_id = event['account']
    event_time = event['detail']['eventTime']
    region = event['region']
    user_identity = event['detail']['userIdentity']

	# Extracting userIdentity details
    principal_id = user_identity.get('principalId')
    user_type = user_identity.get('type')
    user_name = user_identity.get('userName', 'N/A')  # Default to 'N/A' if userName is not present

    # Log extracted event details
    logger.info(f"Event: {json.dumps(event, indent=2)}")
    logger.info(f"Event Name: {event_name}")
    logger.info(f"SNS ARN: {sns_arn}")
    logger.info(f"Key ID: {key_id}")
    logger.info(f"Account ID: {account_id}")
    logger.info(f"Event Time: {event_time}")
    logger.info(f"Region: {region}")
    logger.info(f"Principal ID: {principal_id}")
    logger.info(f"User Type: {user_type}")
    logger.info(f"User Name: {user_name}")

    # Construct the message for SNS
    formatted_message = {
    'default': json.dumps({
        'Event Name': event_name,
        'Key ID': key_id,
        'Account ID': account_id,
        'Event Time': event_time,
        'Region': region,
        'Principal ID': principal_id,
        'User Type': user_type,
        'User Name': user_name
    })
}

    # Initialize SNS client
    sns_client = boto3.client('sns')

    try:
        # Publish the message to the specified SNS topic
        sns_publish_response = sns_client.publish(
            TargetArn=sns_arn,
            Subject=f"KMS Activity Detected: {event_name}",
            Message=json.dumps(formatted_message),
            MessageStructure='json'
        )
        logger.info(f"SNS publish response: {sns_publish_response}")
    except ClientError as e:
        logger.error(f"An error occurred while publishing to SNS: {e}")

