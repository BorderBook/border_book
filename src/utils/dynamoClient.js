// src/utils/dynamoClient.js
import AWS from "aws-sdk";

const dynamoDb = new AWS.DynamoDB.DocumentClient();

const savePaymentToDynamoDB = async (pspReference) => {
  const params = {
    TableName: process.env.DYNAMODB_TABLE,
    Item: {
      pspReference,
      status: "paid",
      createdAt: new Date().toISOString(),
    },
  };

  await dynamoDb.put(params).promise();
};

const QUEUE_TABLE = process.env.QUEUE_TABLE;
const SEQUENCE_TABLE = process.env.SEQUENCE_TABLE; // Use the environment variable

// Function to get the next order number safely
export async function getNextOrder() {
  const params = {
    TableName: SEQUENCE_TABLE,
    Key: { id: "order-sequence" }, // 'order-sequence' is a unique key to track the order number
    UpdateExpression:
      "SET order_value = if_not_exists(order_value, :start) + :incr", // Initialize to 0 if it does not exist, then increment
    ExpressionAttributeValues: { ":incr": 1, ":start": 0 },
    ReturnValues: "UPDATED_NEW",
  };

  try {
    // Atomic update: reads and increments the order_value atomically
    const result = await dynamoDb.update(params).promise();
    return result.Attributes.order_value; // Returns the new incremented value
  } catch (error) {
    console.error("Error incrementing order value:", error);
    throw new Error("Failed to get the next order number");
  }
}

// Handler function to add a new entry to queue-table
export const addEntry = async (event) => {
  const securityCode = event.security_code;

  // Get the next unique order number
  const order = await getNextOrder();

  // Insert the new entry into the queue-table
  const params = {
    TableName: QUEUE_TABLE,
    Item: {
      security_code: securityCode,
      order: order,
      // Add any additional fields needed for your entries
    },
  };

  await dynamoDb.put(params).promise();

  return {
    statusCode: 200,
    body: JSON.stringify({ message: "Entry added", order }),
  };
};
