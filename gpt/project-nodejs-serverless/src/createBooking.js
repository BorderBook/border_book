const mongoose = require('mongoose');
const Booking = require('./models/booking');
const QRCode = require('qr-image');

mongoose.connect(process.env.MONGODB_URI, { useNewUrlParser: true, useUnifiedTopology: true });

module.exports.handler = async (event) => {
  const { firstName, lastName, birthdate, selectedTime } = JSON.parse(event.body);

  const booking = new Booking({
    firstName,
    lastName,
    birthdate: new Date(birthdate),
    selectedTime: new Date(selectedTime),
    orderNumber: await Booking.countDocuments() + 1,
    processed: false,
  });

  await booking.save();

  const qrCodeData = {
    firstName,
    lastName,
    birthdate,
    selectedTime,
    securityCode: booking._id.toString(),
  };

  const qrCode = QRCode.imageSync(JSON.stringify(qrCodeData), { type: 'png' });

  return {
    statusCode: 200,
    body: JSON.stringify({
      orderNumber: booking.orderNumber,
      qrCode: qrCode.toString('base64'),
      securityCode: booking._id.toString(),
    }),
  };
};