const express = require('express');

const controller = require('../controllers/product-customer.controller');

const router = express.Router();

router.get('/', controller.getIndex);

router.get('/product', controller.getProducts);

router.get('/product/:idProduct', controller.getProduct);

module.exports = router;
