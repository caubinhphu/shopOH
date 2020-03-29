const express = require('express');
const csurf = require('csurf');
const path = require('path');
// mimi cart middlware
const miniCartMiddleware = require('../middlewares/miniCart.middleware');
// notification middleware
const notificationMiddleware = require('../middlewares/notification.middleware');
// controller
const controller = require('../controllers/personal-customer.controller');

const csrfProtection = csurf({ cookie: true, signed: true });

const router = express.Router();

router.get(
  '/profile',
  miniCartMiddleware,
  notificationMiddleware,
  csrfProtection,
  controller.getProfile
);

router.put('/profile', csrfProtection, controller.putProfile);

router.put('/profile/avatar', controller.putAvatar);

router.get(
  '/purchase',
  miniCartMiddleware,
  notificationMiddleware,
  controller.getPurchase
);

router.get(
  '/password',
  csrfProtection,
  miniCartMiddleware,
  notificationMiddleware,
  controller.getProfilePassword
);

router.put('/password', csrfProtection, controller.putProfilePassword);

router.get(
  '/notification',
  miniCartMiddleware,
  notificationMiddleware,
  controller.getNotification
);

router.get(
  '/address',
  miniCartMiddleware,
  notificationMiddleware,
  csrfProtection,
  controller.getAddress
);

router.get('/address/hcvn', controller.getHCVN);

router.post(
  '/address',
  miniCartMiddleware,
  notificationMiddleware,
  csrfProtection,
  controller.postAddress
);

router.put('/address/default', controller.putAddressDefault);

router.delete('/address', controller.deleteAddress);

router.get('/address/decode', controller.decodeAddress);

router.put(
  '/address',
  miniCartMiddleware,
  notificationMiddleware,
  csrfProtection,
  controller.putAddress
);

router.get(
  '/purchase/order/:idOrder',
  miniCartMiddleware,
  notificationMiddleware,
  controller.getOrder
);

module.exports = router;
