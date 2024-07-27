import json

print("Loading function")

def lambda_handler(event, context):
    #print("Received event: " + json.dumps(event, indent=2))
    print(f"key1 = {event['key1']}\nkey2 = {event['key2']}\nkey3 = {event['key3']}")

    # return {
    #     'statusCode': 200,
    #     'body': json.dumps('Hello from Lambda!')
    # }
    return event['key1']