const { PrismaClient } = require('@prisma/client');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const prisma = new PrismaClient();

// ====================== GET ALLUSER ======================
const getAllUser = async (req, res) => {
  try {
    const user = await prisma.user.findMany();
    res.status(200).json(user);
  } catch (error) {
    res.status(500).json({ message: 'Fetch Failed' });
  }
};

// ====================== GET ALLUSER ======================
const getUserByID = async (req, res) => {
  const id = req.params.id;
  try {
    const user = await prisma.user.findUnique({
      where: {
        id,
      },
      include: {
        transactions: true,
      },
    });
    res.status(200).json(user);
  } catch (error) {
    res.status(500).json({ message: 'Fetch Failed' });
  }
};

// ====================== REGISTER USER ======================
const registerUser = async (req, res) => {
  const { email, password } = req.body;
  const hashPassword = await bcrypt.hash(password, 10);

  try {
    const user = await prisma.user.create({
      data: {
        email,
        password: hashPassword,
        jwt: '',
      },
    });

    res.status(200).json({ message: 'user berhasil registrasi', user });
  } catch (error) {
    console.log(error);
    res.status(401).json({ message: 'user gagal registrasi', error: error.message });
  }
};

// ====================== LOGIN USER ======================
const loginUser = async (req, res) => {
  const { email, password } = req.body;
  try {
    // PENGECEKAN USER EMAIL
    const user = await prisma.user.findUnique({ where: { email } });
    if (!user) {
      return res.status(401).json({ message: 'user tidak terdaftar' });
    }

    // PENGECEKAN VALID PASSWORD
    const isValidPassword = await bcrypt.compare(password, user.password);

    if (!isValidPassword) {
      return res.status(400).json({ message: 'email atau password salah' });
    }

    // Access Token
    const accessToken = jwt.sign({ id: user.id, email: user.email, role: user.role }, process.env.SECRET_KEY, { expiresIn: '1d' });

    // Refresh Token
    const refreshToken = jwt.sign({ id: user.id, email: user.email, role: user.role }, process.env.SECRET_KEY, { expiresIn: '1d' });

    // MENGIRIMKAN refreshToken ke cookie
    res.cookie('refreshToken', refreshToken, {
      httpOnly: true,
    });

    // UPDATE nilai JWT DATABASE dengan refreshToken
    await prisma.user.update({
      where: {
        id: user.id,
      },
      data: {
        jwt: refreshToken,
      },
    });

    // Jika berhasil kirimkan json
    res.json({
      message: 'user berhasil login',
      user: {
        id: user.id,
        email: user.email,
        role: user.role,
        accessToken: accessToken,
      },
    });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

// ====================== Logout ======================

const logoutUser = async (req, res) => {
  const { email } = req.body;

  // Mengambil refreshToken dari cookie
  const refreshToken = req.cookies.refreshToken;
  if (!refreshToken) return res.sendStatus(204); // status no content

  // Mencari JWT pada databse user yang sama dengan cookie
  const users = await prisma.user.findMany({
    where: {
      jwt: refreshToken,
    },
  });
  if (!users) return res.sendStatus(204); // no content

  // Update JWT database user menjadi null
  await prisma.user.update({
    where: {
      email,
    },
    data: {
      jwt: null,
    },
  });

  // clearCookie
  res.clearCookie('refreshToken');
  res.status(200).json({ message: 'logout berhasil, cookies clear' });
};

// ====================== UPDATE USER ======================

module.exports = { getAllUser, registerUser, loginUser, logoutUser, getUserByID };
