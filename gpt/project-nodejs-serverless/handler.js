'use strict';

const createBooking = require('./src/createBooking');
const validateBooking = require('./src/validateBooking');
const processBooking = require('./src/processBooking');

module.exports.createBooking = createBooking.handler;
module.exports.validateBooking = validateBooking.handler;
module.exports.processBooking = processBooking.handler;