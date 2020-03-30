const express = require('express');
const csurf = require('csurf');
const controller = require('../controllers/admin.controller');

const router = express.Router();

const csrfProtection = csurf({ cookie: true, signed: true });

router.get('/', controller.getHome);

router.get('/product', controller.getProduct);

router.delete('/product/:idPro', controller.deleteProduct);

module.exports = router;
