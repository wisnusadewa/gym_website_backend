const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const updateUser = async ({ userId, memberName, orderId }) => {
  return await prisma.user.update({
    where: {
      id: userId,
    },
    data: {
      transactions: {
        connect: { id: orderId },
      },
      memberName: memberName.join(','),
    },
    include: { transactions: true },
  });
};

module.exports = { updateUser };
