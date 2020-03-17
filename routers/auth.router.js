const express = require('express');

// controller
const controller = require('../controllers/auth.controller');

// init router
const router = express.Router();

// router
router.get('/', controller.getLogin);

router.get('/register', controller.getRegister);

router.post('/', controller.postLogin);

router.get('/logout', controller.getLogout);

// export router
module.exports = router;
