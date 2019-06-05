import boto3
import os

VERIFIED_EMAIL = os.environ['verified_email']

ses = boto3.client('ses')


def lambda_handler(event, context):
    ses.send_email(
        Source=VERIFIED_EMAIL,
        Destination={
            'ToAddresses': [event['email']]                  # Also a verified email
        },
        Message={
            'Subject': {'Data': 'A reminder for Daily Stand Up!!'},
            'Body': {'Text': {'Data': event['message']}}
        }
    )
    return 'Success!'
