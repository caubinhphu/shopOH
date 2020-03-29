const express = require('express');

// controller
const controller = require('../controllers/product-customer.controller');

// mimi cart middlware
const miniCartMiddleware = require('../middlewares/miniCart.middleware');

// filter list middleware
const filterListMiddleware = require('../middlewares/filter-list.middleware');

// notification middleware
const notificationMiddleware = require('../middlewares/notification.middleware');

const authMiddleware = require('../middlewares/auth.middleware');

const router = express.Router();

router.get(
  '/',
  miniCartMiddleware,
  notificationMiddleware,
  controller.getIndex
);

router.get(
  '/product',
  miniCartMiddleware,
  notificationMiddleware,
  controller.getProducts
);

router.get('/product/amount', controller.getAmountProduct);

router.get(
  '/product/search',
  miniCartMiddleware,
  notificationMiddleware,
  controller.searchProduct
);

router.get(
  '/product/:idProduct',
  miniCartMiddleware,
  notificationMiddleware,
  controller.getProduct
);

router.get(
  '/product/style/:style/search',
  miniCartMiddleware,
  notificationMiddleware,
  filterListMiddleware,
  controller.searchStyle
);

router.post('/product/:idProduct/like', authMiddleware, controller.postAddLike);

router.get(
  '/product/style/:style',
  miniCartMiddleware,
  notificationMiddleware,
  filterListMiddleware,
  controller.getStyle
);

module.exports = router;
