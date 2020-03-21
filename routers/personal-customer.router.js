const express = require('express');
const csurf = require('csurf');

// mimi cart middlware
const miniCartMiddleware = require('../middlewares/miniCart.middleware');

// controller
const controller = require('../controllers/personal-customer.controller');

const csrfProtection = csurf({ cookie: true, signed: true });

const router = express.Router();

router.get(
  '/profile',
  miniCartMiddleware,
  csrfProtection,
  controller.getProfile
);

router.post('/profile', csrfProtection, controller.postProfile);

router.get('/purchase', miniCartMiddleware, controller.getPurchase);

router.get('/password', miniCartMiddleware, controller.getProfilePassword);

router.get('/notification', miniCartMiddleware, controller.getNotification);

router.get('/address', miniCartMiddleware, controller.getAddress);

router.put('/profile/avatar', controller.putAvatar);

module.exports = router;
