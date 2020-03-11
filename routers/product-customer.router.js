const express = require('express');

// controller
const controller = require('../controllers/product-customer.controller');

// mimi cart middlware
const miniCartMiddleware = require('../middlewares/miniCart.middleware');

// filter list middleware
const filterListMiddleware = require('../middlewares/filter-list.middleware');

const router = express.Router();

router.get('/', miniCartMiddleware, controller.getIndex);

router.get('/product', miniCartMiddleware, controller.getProducts);

router.get('/product/amount', controller.getAmountProduct);

// router.get('/product/search', controller.searchProduct);

router.get('/product/:idProduct', miniCartMiddleware, controller.getProduct);

router.get(
  '/product/style/:style/search',
  miniCartMiddleware,
  filterListMiddleware,
  controller.searchStyle
);

router.post('/product/:idProduct/like', controller.postAddLike);

router.delete('/product/:idProduct/like', controller.deleteLike);

router.get(
  '/product/style/:style',
  miniCartMiddleware,
  filterListMiddleware,
  controller.getStyle
);

module.exports = router;
