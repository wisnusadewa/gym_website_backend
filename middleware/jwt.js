const jwt = require('jsonwebtoken');

const authentication = async (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];
  if (token === null) return res.status(401).json({ message: 'Unauthorization' });

  jwt.verify(token, process.env.SECRET_KEY, (err, decoded) => {
    if (err) {
      return res.status(403).json({ message: 'invalid token jwt' });
    }
    req.email = decoded.email;
    next();
  });
};

// const isAdmin = async (req, res, next) => {
//   if (req.user.role !== 'ADMIN') return res.status(403).json({ message: 'Forbidden' });
//   next();
// };

module.exports = { authentication };
