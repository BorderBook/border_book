const { gql } = require('apollo-server-lambda');

const typeDefs = gql`
  type Booking {
    id: ID!
    firstName: String!
    lastName: String!
    birthdate: String!
    selectedTime: String!
    orderNumber: Int!
    processed: Boolean!
  }

  type Capacity {
    date: String!
    maxCapacity: Int!
    currentCount: Int!
  }

  type Query {
    validateBooking(securityCode: ID!): Booking
  }

  type Mutation {
    createBooking(firstName: String!, lastName: String!, birthdate: String!, selectedTime: String!): Booking
    processBooking(orderNumber: Int!, capacityCount: Int!): String
  }
`;

module.exports = typeDefs;