const mongoose = require('mongoose');

const CapacitySchema = new mongoose.Schema({
  date: { type: Date, required: true, unique: true },
  maxCapacity: { type: Number, required: true },
  currentCount: { type: Number, required: true, default: 0 }
});

module.exports = mongoose.model('Capacity', CapacitySchema);