const express = require('express');
const serviceController = require('../controller/serviceDB');
const transactionController = require('../controller/Transactions/transactionService');
const middleware = require('../middleware/jwt');

const router = express.Router();

// ROUTES
router.post('/service', serviceController.postServiceDB);
router.get('/service', serviceController.getService);
router.get('/service/:id', middleware.authentication, serviceController.getServiceById);
router.post('/syncService', middleware.authentication, serviceController.SyncService);
router.post('/payment/notification', serviceController.paymentNotification);
router.get('/transaction', transactionController.getAllTransaction);
router.get('/order-status/:orderId', transactionController.getTransactionStatus);

module.exports = router;
