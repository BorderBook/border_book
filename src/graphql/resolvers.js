const { createPaymentSession } = require('../utils/adyenClient');

const resolvers = {
    Query: {
        healthCheck: () => 'Service is running',
    },
    Mutation: {
        createPayment: async (_, { amount }) => {
            try {
                const paymentResponse = await createPaymentSession(amount);
                return {
                    url: paymentResponse.url,
                    message: 'Redirect to the payment page',
                };
            } catch (error) {
                throw new Error('Failed to create payment session');
            }
        },
    },
};

module.exports = resolvers;
