import json
import boto3
from pymongo import MongoClient
from bson.objectid import ObjectId
import qrcode

def lambda_handler(event, context):
    client = MongoClient("your_mongodb_connection_string")
    db = client.border_queue_management
    bookings = db.bookings

    booking_data = json.loads(event['body'])
    booking_data['security_code'] = str(ObjectId())
    
    booking_id = bookings.insert_one(booking_data).inserted_id

    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_L,
        box_size=10,
        border=4,
    )
    qr.add_data(booking_data['security_code'])
    qr.make(fit=True)

    img = qr.make_image(fill='black', back_color='white')
    img.save(f'/tmp/{booking_id}.png')

    s3 = boto3.client('s3')
    s3.upload_file(f'/tmp/{booking_id}.png', 'your_bucket_name', f'{booking_id}.png')

    return {
        'statusCode': 201,
        'body': json.dumps({
            'order_number': str(booking_id),
            'qr_code_url': f'https://your_bucket_name.s3.amazonaws.com/{booking_id}.png'
        })
    }