def lambda_handler(event, context):
    print(event)
    auth = 'Deny'
    if event['authorizationToken'] == 'abc123':
        auth = 'Allow'
    else:
        auth = 'Deny'    

    authResponse = { "principalId": "abc123", "policyDocument": { "Version": "2012-10-17", "Statement": [{ "Action": "execute-api:Invoke", "Resource": ["arn:aws:execute-api:us-east-1:3532325333:545454554/*/*"], "Effect": auth}]}}
    return authResponse