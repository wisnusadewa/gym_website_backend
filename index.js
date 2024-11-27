const cors = require('cors');
const express = require('express');
const userRoutes = require('./routes/userRoutes');
const serviceRoutes = require('./routes/serviceRoutes');
const paymentRoutes = require('./routes/paymentRoutes');
const cookieParser = require('cookie-parser');
require('dotenv').config();
const app = express();

// CORS
// app.use(cors());

app.use((req, res, next) => {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,HEAD,PUT,PATCH,POST,DELETE,OPTIONS,HEAD');
  res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Accept, Content-Type, Authorization', 'application/json');

  // preflight request
  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  } else {
    next();
  }
});

app.use(express.json({ strict: false }));
app.use(cookieParser());

// ROUTES
app.use('/api', userRoutes);
app.use('/api', serviceRoutes);
// app.use('/api', paymentRoutes);

app.listen(5001, () => {
  console.log('server running!');
});

module.exports = app;
