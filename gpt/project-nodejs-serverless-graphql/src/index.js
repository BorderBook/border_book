const { ApolloServer } = require('apollo-server-lambda');
const connectDB = require('./db');
const typeDefs = require('./schema');
const resolvers = require('./resolvers');

connectDB();

const server = new ApolloServer({
  typeDefs,
  resolvers,
  context: ({ event, context }) => ({
    headers: event.headers,
    functionName: context.functionName,
    event,
    context
  }),
  playground: true,
  introspection: true
});

exports.handler = server.createHandler({
  cors: {
    origin: '*',
    credentials: true
  }
});