const express = require('express');
const controller = require('../controllers/checkout-controller');

// middleware
const notificationMiddleware = require('../middlewares/notification.middleware');

const router = express.Router();

router.get('/gettoken', controller.getToken);

router.get('/', notificationMiddleware, controller.getCheckout);

router.post('/', controller.postCheckout);

module.exports = router;
