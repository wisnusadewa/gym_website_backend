const { PrismaClient } = require('@prisma/client');
const { MIDTRANS_SERVER_KEY, MIDTRANS_APP_URL } = require('./Transactions/constant');
const paymentMidtrans = require('./Transactions/paymetMidtrans');
const crypto = require('crypto');
const userService = require('./User/userService');
const transactionService = require('./Transactions/transactionService');

// const snap = require('./Transactions/paymentService');
const prisma = new PrismaClient();

const postServiceDB = async (req, res) => {
  const { pax, price, month, tags, description, duration } = req.body;
  try {
    const services = await prisma.service.create({
      data: {
        pax,
        price,
        month,
        tags,
        duration,
        description: description.join(', '), // Gabungkan array menjadi string dengan separator koma
      },
    });
    res.status(200).json(services);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'add service failed' });
  }
};

// ===========

const getService = async (req, res) => {
  try {
    const services = await prisma.service.findMany();
    res.status(200).json(services);
  } catch (error) {
    res.status(500).json({ message: 'message failed' });
  }
};

// ============

const getServiceById = async (req, res) => {
  try {
    const id = req.params.id;
    const services = await prisma.service.findUnique({
      where: {
        id,
      },
      include: {
        transactionItem: true,
      },
    });
    res.status(200).json(services);
  } catch (error) {
    res.status(500).json({ message: 'fetch failed' });
  }
};

//   ==================== SYNC SERVICE PROFILE AND MIDTRANS ====================

const SyncService = async (req, res) => {
  const { userId, serviceId, memberName, dateStart, priceTotal, duration } = req.body;
  const user = await prisma.user.findUnique({ where: { id: userId } });
  const orderId = `${serviceId}-${Date.now()}`;

  const dateEnd = new Date(dateStart);
  dateEnd.setMonth(dateEnd.getMonth() + duration);

  if (![1, 3, 6].includes(duration)) {
    return res.status(400).json({ message: 'Durasi tidak valid, hanya 1,3 atau 6 bulan yang diperbolehkan.' });
  }

  try {
    // CREATE TRANSACTION
    // await Promise.all([transactionService.createTransaction({ userId, orderId, dateStart, dateEnd }), transactionService.createTransactionItem({ serviceId, orderId })]);

    const createTransaction = await transactionService.createTransaction({ userId, orderId, dateStart, dateEnd, serviceId });

    // UPDATE USER DI DB
    const updateUser = await userService.updateUser({ userId, orderId, memberName });

    // MEMBUAT SNAP
    const transactions = await paymentMidtrans(orderId, priceTotal, {
      email: user.email,
    });

    await res.json({
      createTransaction,
      orderId,
      updateUser,
      data: {
        snap_token: transactions.token,
        snap_redirect_url: transactions.redirect_url,
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error Sync', error: error.message });
  }
};

//   ==================== WEBHOOK NOTIFICATION ====================

const paymentNotification = async (req, res) => {
  try {
    const notification = req.body;
    const orderId = notification.order_id;
    const transactionStatus = notification.transaction_status;
    const fraudStatus = notification.fraud_status;
    const status_code = notification.status_code;
    const gross_amount = notification.gross_amount;

    const hash = crypto.createHash('sha512').update(`${orderId}${status_code}${gross_amount}${MIDTRANS_SERVER_KEY}`).digest('hex');
    if (notification.signature_key !== hash) {
      return {
        status: 'error',
        message: 'Invalid signature_key',
      };
    }

    const responseData = null;

    // Logika penanganan berdasarkan status transaksi
    if (transactionStatus === 'capture') {
      if (fraudStatus === 'challenge') {
        // Pembayaran perlu verifikasi lebih lanjut
        console.log(`Order ${orderId} perlu verifikasi lebih lanjut.`);
      } else if (fraudStatus === 'accept') {
        // Pembayaran berhasil
        // Update status user atau order di database
        const transactionStatusPayment = 'PAID';
        const transactionStatusUser = 'ACTIVE';
        const transaction = await transactionService.updateTransactionAfterPayment({ orderId, transactionStatusPayment, transactionStatusUser });
        responseData = transaction;

        console.log(`Order ${orderId} berhasil.`);
      }
    } else if (transactionStatus === 'settlement') {
      // Pembayaran selesai
      // Update status user atau order di database
      const transactionStatusPayment = 'PAID';
      const transactionStatusUser = 'ACTIVE';
      const transaction = await transactionService.updateTransactionAfterPayment({ orderId, transactionStatusPayment, transactionStatusUser });
      responseData = transaction;

      console.log(`Order ${orderId} selesai.`);
    } else if (transactionStatus === 'deny') {
      // Pembayaran ditolak
      console.log(`Order ${orderId} ditolak.`);
    } else if (transactionStatus === 'cancel' || transactionStatus === 'expire') {
      // Pembayaran dibatalkan atau kadaluarsa
      // const transaction = await transactionService.updateTransactionAfterPayment({ orderId, transactionStatusPayment: 'REJECT', transactionStatusUser: 'NONE' });
      // responseData = transaction;

      console.log(`Order ${orderId} dibatalkan atau kadaluarsa.`);
    } else if (transactionStatus === 'pending') {
      // Pembayaran tertunda
      // const transaction = await transactionService.updateTransactionAfterPayment({ orderId, transactionStatusPayment: 'PENDING', transactionStatusUser: 'PENDING' });
      // responseData = transaction;
      // console.log(`Order ${orderId} tertunda.`);
    }

    return res.status(200).json({
      status: 'success',
      data: responseData,
      message: 'Notifikasi diterima',
    });
  } catch (error) {
    console.error('Error dalam menangani webhook:', error);
    res.status(500).json({ message: 'Error dalam menangani webhook' });
  }
};

module.exports = { postServiceDB, getService, getServiceById, SyncService, paymentNotification };
