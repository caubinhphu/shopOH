const express = require('express');

const controller = require('../controllers/cart-customer.controller');

const router = express.Router();

router.route('/')
      .get(controller.getCart)
      .post(controller.postAddCart)
      .delete(controller.deleteCart)
      .put(controller.putCart);


module.exports = router;