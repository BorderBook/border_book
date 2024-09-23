const { savePaymentToDynamoDB } = require('../utils/dynamoClient');

exports.handler = async (event) => {
    try {
        const { notificationItems } = JSON.parse(event.body);

        for (const item of notificationItems) {
            const { success, pspReference } = item.NotificationRequestItem;

            if (success) {
                await savePaymentToDynamoDB(pspReference);
            }
        }

        return {
            statusCode: 200,
            body: JSON.stringify({ message: 'Notification processed' }),
        };
    } catch (error) {
        return {
            statusCode: 500,
            body: JSON.stringify({ message: 'Error processing notification' }),
        };
    }
};
