def lambda_handler(event, context):
    print(event)
    auth = 'Deny'
    if event['authorizationToken'] == 'test123':
        auth = 'Allow'

    authResponse = { "principalId": "test123", "policyDocument": { "Version": "2012-10-17", "Statement": [{ "Action": "execute-api:Invoke", "Resource": [event['methodArn']], "Effect": auth}]}}
    return authResponse