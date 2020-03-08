const querySQL = require('../configure/querySQL');

module.exports.deleteCart = async (req, res, next) => {
	try {
		let cartInfo = req.body.info.split('$');
		cartInfo.unshift(1);
		await querySQL('call SP_DELETE_CART(?, ?, ?, ?)', cartInfo);
		let dataCart = await querySQL('call SP_SELECT_CART(?)', [1]);
		let [cartNum, cartProduct] = dataCart;
		res.send([cartNum, cartProduct]);
	} catch (error) {
		next(error);
	}
};

module.exports.postAddCart = async (req, res, next) => {
	try {
		let data = req.body;
		await querySQL('call SP_INSERT_CART(?, ?, ?, ?, ?)', [
			data.idPro,
			1, ///////////////////
			data.color,
			data.size,
			data.quantity
		]);
		let dataCart = await querySQL('call SP_SELECT_CART(?)', [1]);
		let [cartNum, cartProduct] = dataCart;
		res.send([cartNum, cartProduct]);
	} catch (error) {
		next(error);
	}
};

module.exports.getCart = async (req, res, next) => {
	try {
		let dataCart = await querySQL('call SP_SELECT_CART(?)', [1]);
		let dataSuggestion = await querySQL('call SP_SELECT_PRODUCT_SUGGESTION()');
		res.render('customer/cart', {
			titleSite: 'ShopOH - Giỏ hàng',
			cartNum: dataCart[0][0],
			cartProduct: dataCart[1],
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
		cartInfo.unshift(1);
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
			let dataCart = await querySQL('call SP_SELECT_CART(?)', [1]);
			let [cartNum, cartProduct] = dataCart;
			res.send([cartNum, cartProduct]);
		} else {
			res.send([[{ sl: 0, slsp: 0, tongtien: 0 }], []]);
		}
	} catch (error) {
		next(error);
	}
};
