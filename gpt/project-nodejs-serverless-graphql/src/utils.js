const QRCode = require('qrcode');

const generateQRCode = async (booking) => {
  const qrData = {
    id: booking._id,
    firstName: booking.firstName,
    lastName: booking.lastName,
    birthdate: booking.birthdate,
    selectedTime: booking.selectedTime,
    orderNumber: booking.orderNumber
  };
  return await QRCode.toDataURL(JSON.stringify(qrData));
};

module.exports = { generateQRCode };