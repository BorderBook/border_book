const mongoose = require('mongoose');
const Booking = require('./models/booking');

mongoose.connect(process.env.MONGODB_URI, { useNewUrlParser: true, useUnifiedTopology: true });

module.exports.handler = async (event) => {
  const { qrCode } = JSON.parse(event.body);
  const qrCodeData = JSON.parse(Buffer.from(qrCode, 'base64').toString('utf8'));

  const booking = await Booking.findById(qrCodeData.securityCode);

  if (!booking) {
    return {
      statusCode: 404,
      body: JSON.stringify({ message: 'Booking not found' }),
    };
  }

  return {
    statusCode: 200,
    body: JSON.stringify({
      firstName: booking.firstName,
      lastName: booking.lastName,
      birthdate: booking.birthdate,
      selectedTime: booking.selectedTime,
    }),
  };
};