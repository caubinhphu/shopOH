const express = require('express');

const controller = require('../controllers/cart-customer.controller');

// cart middleware
const cartMiddleware = require('../middlewares/miniCart.middleware');
const notificationMiddleware = require('../middlewares/notification.middleware');

const router = express.Router();

router
  .route('/')
  .get(cartMiddleware, notificationMiddleware, controller.getCart)
  .post(controller.postAddCart)
  .delete(controller.deleteCart)
  .put(controller.putCart);

router.get('/mini', controller.getCartData);

module.exports = router;
