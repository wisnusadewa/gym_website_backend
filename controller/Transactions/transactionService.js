const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const createTransaction = async ({ orderId, userId, dateStart, dateEnd, serviceId }) => {
  return await prisma.transactions.create({
    data: {
      userId,
      id: orderId,
      transactionStatusPayment: 'NONE',
      transactionStatusUser: 'NONE',
      dateStart: new Date(dateStart),
      dateEnd,
      transactionItem: {
        create: {
          id: `TRX-${orderId}-${Date.now()}`,
          serviceId,
        },
      },
    },
    include: {
      transactionItem: true,
    },
  });
};

const getAllTransaction = async (req, res) => {
  try {
    const allTransaction = await prisma.transactions.findMany();
    res.status(200).json(allTransaction);
  } catch (error) {
    console.log(error);
  }
};

const getTransactionStatus = async (req, res) => {
  const { orderId } = req.params;
  const transactionStatus = await prisma.transactions.findUnique({
    where: {
      id: orderId,
    },
  });
  res.json(transactionStatus);
};

const updateTransactionAfterPayment = async ({ orderId, transactionStatusPayment, transactionStatusUser }) => {
  return await prisma.transactions.update({
    where: {
      id: orderId,
    },
    data: {
      transactionStatusPayment,
      transactionStatusUser,
    },
  });
};

module.exports = { createTransaction, getTransactionStatus, getAllTransaction, updateTransactionAfterPayment };
