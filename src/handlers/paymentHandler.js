const { ApolloServer } = require('@apollo/server');
const { startServerAndCreateLambdaHandler } = require('@as-integrations/aws-lambda');
const typeDefs = require('../graphql/schema.graphql');
const resolvers = require('../graphql/resolvers');

const server = new ApolloServer({
    typeDefs,
    resolvers,
});

exports.handler = startServerAndCreateLambdaHandler(server);
