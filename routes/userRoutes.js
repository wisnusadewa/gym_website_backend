const express = require('express');
const { refreshTokenFunc } = require('../controller/refreshToken');
const userController = require('../controller/userController');
const middleware = require('../middleware/jwt');

const router = express.Router();
// ROUTES

router.get('/users', middleware.authentication, userController.getAllUser);
router.get('/users/:id', middleware.authentication, userController.getUserByID);
router.post('/register', userController.registerUser);
router.post('/login', userController.loginUser);
router.get('/token', refreshTokenFunc);
router.delete('/logout', userController.logoutUser);

module.exports = router;
