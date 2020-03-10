const querySQL = require('../configure/querySQL');

// remove product in cart
module.exports.deleteCart = async (req, res, next) => {
	try {
		// get info prodct want remove
		let cartInfo = req.body.info.split('$');
		cartInfo.unshift('1'); // unshift current user

		// remove product from cart
		await querySQL('call SP_DELETE_CART(?, ?, ?, ?)', cartInfo);

		// get new cart after remove prodcut from cart
		let dataCart = await querySQL('call SP_SELECT_CART(?)', ['1']);
		let [cartNum, cartProduct] = dataCart;

		// send to client
		res.json([cartNum, cartProduct]);
	} catch (error) {
		next(error);
	}
};

// add prduct to the cart
module.exports.postAddCart = async (req, res, next) => {
	try {
		// get info post from client
		let data = req.body;

		// add product to the cart
		await querySQL('call SP_INSERT_CART(?, ?, ?, ?, ?)', [
			data.idPro,
			'1', // current user
			data.color, // color product
			data.size, // size product
			data.quantity // quantity
		]);

		// get new cart after add product
		let dataCart = await querySQL('call SP_SELECT_CART(?)', ['1']);

		// send to client
		let [cartNum, cartProduct] = dataCart;
		res.send([cartNum, cartProduct]);
	} catch (error) {
		next(error);
	}
};

module.exports.getCart = async (req, res, next) => {
	try {
		let dataSuggestion = await querySQL('call SP_SELECT_PRODUCT_SUGGESTION()');
		let sumPirce = await querySQL('call SP_GET_SUMPRICE_CART(?)', ['1']);
		res.render('customer/cart', {
			titleSite: 'ShopOH - Giỏ hàng',
			sumPrice: sumPirce[0][0],
			productSuggestionList: dataSuggestion[0]
		});
	} catch (error) {
		next(error);
	}
};

module.exports.putCart = async (req, res, next) => {
	try {
		let cartInfo = req.body.info.split('$');
		let sl = req.body.sl;
		cartInfo.unshift('1');
		cartInfo.push(sl);
		await querySQL('call SP_UPDATE_CART(?, ?, ?, ?, ?)', cartInfo);
		res.send({});
	} catch (error) {
		next(error);
	}
};

module.exports.getCartData = async (req, res, next) => {
	try {
		// let idUser = parseInt(req.params.idUser);
		if (1 === 1) {
			let dataCart = await querySQL('call SP_SELECT_CART(?)', ['1']);
			let [cartNum, cartProduct] = dataCart;
			res.send([cartNum, cartProduct]);
		} else {
			res.send([[{ sl: 0, slsp: 0, tongtien: 0 }], []]);
		}
	} catch (error) {
		next(error);
	}
};
