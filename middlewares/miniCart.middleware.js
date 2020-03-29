// SQL query function
const querySQL = require('../configure/querySQL');
const { myEncode } = require('../configure/myEncode');

module.exports = async function getMiniCartData(req, res, next) {
  if (!req.userId) {
    res.locals.cartNum = { slsp: 0 };
  } else {
    let dataCart = await querySQL('call SP_SELECT_CART(?)', [req.userId]);
    // set locals tổng số sản phẩm trong giỏ hàng
    res.locals.cartNum = dataCart[0][0];
    // get cartProduct
    let cartProduct = dataCart[1];
    // add field encode to cartProduct
    for (let item of cartProduct) {
      item.encode = myEncode(
        item.ma_sanpham.concat('$', item.mausac, '$', item.size)
      );
    }
    // set locals danh sách sản phẩm trong giỏ
    res.locals.cartProduct = cartProduct;
  }

  next();
};
