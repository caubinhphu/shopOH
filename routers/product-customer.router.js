const express = require('express');

const controller = require('../controllers/product-customer.controller');

const router = express.Router();

router.get('/', controller.getIndex);

router.get('/product', controller.getProducts);

router.get('/product/:idProduct', controller.getProduct);

router.get('/product/:idProduct/:color/:size', controller.getAmountProduct);

router.post('/product/:idProduct/like', controller.postAddLike);

router.delete('/product/:idProduct/like', controller.deleteLike);

module.exports = router;
