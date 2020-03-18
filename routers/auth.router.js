const express = require('express');
const csurf = require('csurf');

const csrfProtection = csurf({ cookie: true, signed: true });

// controller
const controller = require('../controllers/auth.controller');

// init router
const router = express.Router();

// router
router.get('/', csrfProtection, controller.getLogin);

router.get('/register', csrfProtection, controller.getRegister);

router.post('/', csrfProtection, controller.postLogin);

router.post('/register', csrfProtection, controller.postRegister);

router.get('/logout', controller.getLogout);

// export router
module.exports = router;
