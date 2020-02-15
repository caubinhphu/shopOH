const querySQL = require('../configure/querySQL');

module.exports.deleteCart = async (req, res, next) => {
  try {
    let cartInfo = req.params.cart.split('$');
    await querySQL('call SP_DELETE_CART(?, ?, ?, ?)', cartInfo);
    let dataCart = await querySQL('call SP_SELECT_CART(?)', [1]);
    res.send(dataCart);
  } catch (error) {
    next(error);
  }
}

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
    res.send(dataCart);
  } catch (error) {
    next(error);
  }
}

module.exports.getCart = async (req, res, next) => {
  try {
    let dataCart = await querySQL('call SP_SELECT_CART(?)', [1]);
    let dataSuggestion = await querySQL('call SP_SELECT_PRODUCT_SUGGESTION()');
    res.render('customer/cart', {
      titleSite: 'ShopOH - Giở hàng',
      cartNum: dataCart[0][0],
      cartProduct: dataCart[1],
      productSuggestionList: dataSuggestion[0]
    })
  } catch (error) {
    next(error);
  }
}

