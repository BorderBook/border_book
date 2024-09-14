const mongoose = require('mongoose');

const BookingSchema = new mongoose.Schema({
  firstName: { type: String, required: true },
  lastName: { type: String, required: true },
  birthdate: { type: Date, required: true },
  selectedTime: { type: Date, required: true },
  orderNumber: { type: Number, required: true, unique: true },
  processed: { type: Boolean, default: false }
});

module.exports = mongoose.model('Booking', BookingSchema);