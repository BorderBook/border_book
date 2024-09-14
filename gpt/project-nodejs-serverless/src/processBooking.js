const mongoose = require('mongoose');
const Booking = require('./models/booking');
const Capacity = require('./models/capacity');

mongoose.connect(process.env.MONGODB_URI, { useNewUrlParser: true, useUnifiedTopology: true });

module.exports.handler = async (event) => {
  const { orderNumber, capacityCount } = JSON.parse(event.body);

  const booking = await Booking.findOne({ orderNumber });

  if (!booking) {
    return {
      statusCode: 404,
      body: JSON.stringify({ message: 'Booking not found' }),
    };
  }

  booking.processed = true;
  await booking.save();

  const today = new Date().setHours(0, 0, 0, 0);
  let capacity = await Capacity.findOne({ date: today });

  if (!capacity) {
    capacity = new Capacity({
      date: today,
      maxCapacity: capacityCount,
      currentCount: 0,
    });
  }

  capacity.currentCount += 1;
  await capacity.save();

  return {
    statusCode: 200,
    body: JSON.stringify({ message: 'Booking processed successfully' }),
  };
};