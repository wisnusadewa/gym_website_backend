const { MIDTRANS_SERVER_KEY, MIDTRANS_APP_URL } = require('./constant');
const axios = require('axios');

const paymentMidtrans = async (orderId, priceTotal, customerDetails) => {
  try {
    const response = await axios.post(
      `${MIDTRANS_APP_URL}/snap/v1/transactions`,
      {
        transaction_details: {
          order_id: orderId,
          gross_amount: priceTotal,
        },
        customer_details: customerDetails,
      },
      {
        headers: {
          'Content-Type': 'application/json',
          Accept: 'application/json',
          Authorization: 'Basic ' + Buffer.from(`${MIDTRANS_SERVER_KEY}` + ':').toString('base64'),
        },
      }
    );

    return response.data;
  } catch (error) {
    console.error('Error creating transaction:', error.response ? error.response.data : error.message);
    throw new Error('Gagal membuat transaksi');
  }
};

module.exports = paymentMidtrans;
