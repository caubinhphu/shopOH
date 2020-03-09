const express = require('express');

// controller
const controller = require('../controllers/product-customer.controller');

// mimi cart middlware
const miniCartMiddleware = require('../middlewares/miniCart.middleware');

const router = express.Router();

router.get('/', miniCartMiddleware, controller.getIndex);

router.get('/product', miniCartMiddleware, controller.getProducts);

router.get('/product/:idProduct', miniCartMiddleware, controller.getProduct);

router.get('/product/:idProduct/:color/:size', controller.getAmountProduct);

router.post('/product/:idProduct/like', controller.postAddLike);

router.delete('/product/:idProduct/like', controller.deleteLike);

router.get('/product/style/:style', controller.getStyle);

module.exports = router;
