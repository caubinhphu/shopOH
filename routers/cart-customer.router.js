const express = require('express');

const controller = require('../controllers/cart-customer.controller');

const router = express.Router();

router.get('/', controller.getCart);

router.post('/add', controller.postAddCart);

router.delete('/:cart', controller.deleteCart);


module.exports = router;