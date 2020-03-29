const express = require('express');
const csurf = require('csurf');
const controller = require('../controllers/adminAuth.controller');

const router = express.Router();

const csrfProtection = csurf({ cookie: true, signed: true });

router.get('/', csrfProtection, controller.getAuth);

router.post('/', csrfProtection, controller.postAuth);

router.post('/logout', controller.logout);

module.exports = router;
