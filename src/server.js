// src/server.js

import { ApolloServer } from "@apollo/server";
import {
  startServerAndCreateLambdaHandler,
  handlers,
} from "@as-integrations/aws-lambda";
import { getNextOrder } from "./utils/dynamoClient.js";

// Define your type definitions and resolvers
const typeDefs = `#graphql
  type Query {
    hello: String
    nextOrder: Int
  }
`;

const resolvers = {
  Query: {
    hello: () => "world",
    nextOrder: async () => {
      // Call the getNextOrder function to test DynamoDB integration
      try {
        const order = await getNextOrder();
        return order;
      } catch (error) {
        console.error("Error fetching the next order:", error);
        throw new Error("Failed to fetch the next order");
      }
    },
  },
};

// Create the Apollo Server with a custom landing page to enable the GraphQL Playground
const server = new ApolloServer({
  typeDefs,
  resolvers,
  introspection: true, // Enables schema introspection for the Playground
  plugins: [
    {
      async serverWillStart() {
        return {
          async renderLandingPage() {
            // Enable GraphQL Playground as the landing page
            return {
              html: `
                <!DOCTYPE html>
                <html lang="en">
                <head>
                  <meta charset="utf-8" />
                  <title>GraphQL Playground</title>
                  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/graphql-playground-react@1.7.20/build/static/css/index.css" />
                  <link rel="shortcut icon" href="https://cdn.jsdelivr.net/npm/graphql-playground-react@1.7.20/build/favicon.png" />
                  <script src="https://cdn.jsdelivr.net/npm/graphql-playground-react@1.7.20/build/static/js/middleware.js"></script>
                </head>
                <body>
                  <div id="root"></div>
                  <script>
                    window.addEventListener('load', function (event) {
                      GraphQLPlayground.init(document.getElementById('root'), {
                        endpoint: '/',
                        settings: {
                          'schema.polling.enable': false // Disable schema polling
                          // 'schema.polling.interval': 10000 // Optional: Set polling interval to 10 seconds
                        }
                      })
                    })
                  </script>
                </body>
                </html>
              `,
            };
          },
        };
      },
    },
  ],
});

// Export the handler to be used with AWS Lambda and Serverless Framework
export const graphqlHandler = startServerAndCreateLambdaHandler(
  server,
  handlers.createAPIGatewayProxyEventV2RequestHandler(),
);
