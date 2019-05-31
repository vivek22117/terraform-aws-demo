import boto3
import json
import os
import decimal

STEP_FUN_ARN = os.environ['STEP_FUN_ARN']

sfn = boto3.client('stepfunctions')


def lambda_handler(event, context):
    print('EVENT:')
    print(event)
    data = json.loads(event['body'])
    data['waitSeconds'] = int(data['waitSeconds'])

    # Validation Checks
    checks = list()
    checks.append('waitSeconds' in data)
    checks.append(type(data['waitSeconds']) == int)
    checks.append('preference' in data)
    checks.append('message' in data)
    if data.get('preference') == 'sms':
        checks.append('phone' in data)
    if data.get('preference') == 'email':
        checks.append('email' in data)

    # Check for any errors in validation checks
    if False in checks:
        response = {
            "statusCode": 400,
            "headers": {"Access-Control-Allow-Origin":"*"},
            "body": json.dumps(
                {
                    "Status": "Success",
                    "Reason": "Input failed validation"
                },
                cls=DecimalEncoder
            )
        }
    # If none, run the state machine and return a 200 code saying this is fine :)
    else:
        sfn.start_execution(
            stateMachineArn=STEP_FUN_ARN,
            input=json.dumps(data, cls=DecimalEncoder)
        )
        response = {
            "statusCode": 200,
            "headers": {"Access-Control-Allow-Origin":"*"},
            "body": json.dumps(
                {"Status": "Success"},
                cls=DecimalEncoder
            )
        }
    return response


class DecimalEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, decimal.Decimal):
            return int(obj)
        return super(DecimalEncoder, self).default(obj)
