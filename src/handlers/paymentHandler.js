import { ApolloServer } from "@apollo/server";
import { startServerAndCreateLambdaHandler } from "@as-integrations/aws-lambda";
import typeDefs from "../graphql/schema.graphql"; // Assuming schema.graphql is handled as an importable module
import resolvers from "../graphql/resolvers"; // Ensure resolvers are exported correctly as a default export

const server = new ApolloServer({
  typeDefs,
  resolvers,
});

export const handler = startServerAndCreateLambdaHandler(server);
