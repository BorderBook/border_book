const mongoose = require('mongoose');

const capacitySchema = new mongoose.Schema({
  date: { type: Date, unique: true },
  maxCapacity: Number,
  currentCount: { type: Number, default: 0 },
});

module.exports = mongoose.model('Capacity', capacitySchema);