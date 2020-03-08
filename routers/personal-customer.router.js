const express = require('express');

const router = express.Router();

router.get('/', (req, res, next) => {
	res.render('customer/personal', {
		titleSite: 'ShopOH - Tài khoản của tôi'
	});
});

module.exports = router;
