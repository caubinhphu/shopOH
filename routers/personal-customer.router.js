const express = require('express');
const csurf = require('csurf');

// mimi cart middlware
const miniCartMiddleware = require('../middlewares/miniCart.middleware');

// controller
const controller = require('../controllers/personal-customer.controller');

const csrfProtection = csurf({ cookie: true, signed: true });

const router = express.Router();

router.use(miniCartMiddleware);

router.get('/profile', csrfProtection, controller.getProfile);

router.post('/profile', csrfProtection, controller.postProfile);

router.get('/purchase', controller.getPurchase);

router.get('/password', controller.getProfilePassword);

router.get('/notification', controller.getNotification);

router.get('/address', controller.getAddress);

module.exports = router;
