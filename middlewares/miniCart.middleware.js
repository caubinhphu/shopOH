// SQL query function
const querySQL = require('../configure/querySQL');

module.exports = async function getMiniCartData(req, res, next) {
	let dataCart = await querySQL('call SP_SELECT_CART(?)', [1]);
	res.locals.cartNum = dataCart[0][0]; // set locals tổng số sản phẩm trong giỏ hàng
	res.locals.cartProduct = dataCart[1]; // set locals danh sách sản phẩm trong giỏ
	next();
};
