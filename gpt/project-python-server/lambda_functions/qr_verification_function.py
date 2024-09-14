import json
from pymongo import MongoClient

def lambda_handler(event, context):
    client = MongoClient("your_mongodb_connection_string")
    db = client.border_queue_management
    bookings = db.bookings

    qr_code = json.loads(event['body'])['qrCode']
    booking = bookings.find_one({'security_code': qr_code})

    if booking:
        return {
            'statusCode': 200,
            'body': json.dumps({
                'firstName': booking['firstName'],
                'lastName': booking['lastName'],
                'birthdate': booking['birthdate'],
                'timeSlot': booking['timeSlot']
            })
        }
    else:
        return {
            'statusCode': 404,
            'body': json.dumps({'message': 'Invalid QR Code'})
        }