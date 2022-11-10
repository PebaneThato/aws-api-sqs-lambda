def lambda_handler(event, context):
    data = event['Records'][0]['body']
    print(data)