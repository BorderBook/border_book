import axios from "axios"; // Import axios as default in ESM

const createPaymentSession = async (amount) => {
  const url = "https://checkout-test.adyen.com/v67/paymentLinks";
  const headers = {
    "Content-Type": "application/json",
    "x-API-key": process.env.ADYEN_API_KEY,
  };

  const data = {
    amount: { currency: "EUR", value: amount * 100 }, // 1 EUR is 100 cents
    reference: "ORDER-12345",
    merchantAccount: process.env.ADYEN_MERCHANT_ACCOUNT,
    returnUrl: "https://yourapp.com/return",
  };

  const response = await axios.post(url, data, { headers });
  return response.data;
};

export { createPaymentSession }; // Export the function in ESM syntax
