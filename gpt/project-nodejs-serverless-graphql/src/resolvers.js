const { Booking, Capacity } = require('./models');
const { ApolloError } = require('apollo-server-lambda');
const { generateQRCode } = require('./utils');

const resolvers = {
  Query: {
    validateBooking: async (_, { securityCode }) => {
      try {
        const booking = await Booking.findById(securityCode);
        if (!booking) {
          throw new ApolloError('Booking not found');
        }
        return booking;
      } catch (err) {
        throw new ApolloError(err.message);
      }
    }
  },
  Mutation: {
    createBooking: async (_, { firstName, lastName, birthdate, selectedTime }) => {
      try {
        const orderNumber = await Booking.countDocuments() + 1;
        const booking = new Booking({
          firstName,
          lastName,
          birthdate,
          selectedTime,
          orderNumber,
          processed: false
        });
        await booking.save();
        const qrCode = await generateQRCode(booking);
        return { ...booking._doc, qrCode };
      } catch (err) {
        throw new ApolloError(err.message);
      }
    },
    processBooking: async (_, { orderNumber, capacityCount }) => {
      try {
        const booking = await Booking.findOne({ orderNumber });
        if (!booking) {
          throw new ApolloError('Booking not found');
        }
        booking.processed = true;
        await booking.save();

        const today = new Date().toISOString().split('T')[0];
        let capacity = await Capacity.findOne({ date: today });
        if (!capacity) {
          capacity = new Capacity({ date: today, maxCapacity: capacityCount, currentCount: 0 });
        }
        capacity.currentCount += 1;
        await capacity.save();

        return 'Booking processed successfully';
      } catch (err) {
        throw new ApolloError(err.message);
      }
    }
  }
};

module.exports = resolvers;