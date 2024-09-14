import json
from pymongo import MongoClient

def lambda_handler(event, context):
    client = MongoClient("your_mongodb_connection_string")
    db = client.border_queue_management
    capacity = db.capacity

    if event['httpMethod'] == 'GET':
        current_capacity = capacity.find_one()
        return {
            'statusCode': 200,
            'body': json.dumps({'capacity': current_capacity['value']})
        }
    elif event['httpMethod'] == 'POST':
        new_capacity = json.loads(event['body'])['capacity']
        capacity.update_one({}, {'$set': {'value': new_capacity}}, upsert=True)
        return {
            'statusCode': 200,
            'body': json.dumps({'message': 'Capacity updated successfully'})
        }