const { PrismaClient } = require('@prisma/client');
const jwt = require('jsonwebtoken');

const prisma = new PrismaClient();

const refreshTokenFunc = async (req, res) => {
  try {
    // Mengambil refreshToken pada cookie
    const refreshToken = req.cookies.refreshToken;
    if (!refreshToken) return res.sendStatus(403); // status no content

    // MENCARI JWT pada database yang sama dengan cookies
    const users = await prisma.user.findMany({
      where: {
        jwt: refreshToken,
      },
    });

    if (!users) return res.sendStatus(403); // status no content

    //   JWT VERIFY
    jwt.verify(refreshToken, process.env.SECRET_KEY, (err, decoded) => {
      if (err) return res.sendStatus(403);
      const accessToken = jwt.sign(
        {
          id: users.id,
          email: users.email,
          role: users.role,
        },
        process.env.SECRET_KEY,
        { expiresIn: '30s' }
      );
      res.json({ accessToken });
    });
  } catch (error) {
    console.log(error);
  }
};

module.exports = { refreshTokenFunc };
