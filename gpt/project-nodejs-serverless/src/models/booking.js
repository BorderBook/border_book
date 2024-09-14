const mongoose = require('mongoose');

const bookingSchema = new mongoose.Schema({
  firstName: String,
  lastName: String,
  birthdate: Date,
  selectedTime: Date,
  orderNumber: Number,
  processed: { type: Boolean, default: false },
});

module.exports = mongoose.model('Booking', bookingSchema);