const express = require('express');
const controller = require('../controllers/checkout-controller');

const router = express.Router();

router.get('/gettoken', controller.getToken);

router.get('/', controller.getCheckout);

router.post('/', controller.postCheckout);

module.exports = router;
