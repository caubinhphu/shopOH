const querySQL = require('../configure/querySQL');

// remove product in cart
module.exports.deleteCart = async (req, res, next) => {
  try {
    // get info prodct want remove
    let cartInfo = req.body.info.split('$');
    cartInfo.unshift(req.signedCookies.uuid); // unshift current user

    // remove product from cart
    await querySQL('call SP_DELETE_CART(?, ?, ?, ?)', cartInfo);

    // get new cart after remove prodcut from cart
    let dataCart = await querySQL('call SP_SELECT_CART(?)', [
      req.signedCookies.uuid
    ]);
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
      req.signedCookies.uuid, // current user
      data.color, // color product
      data.size, // size product
      data.quantity // quantity
    ]);

    // get new cart after add product
    let dataCart = await querySQL('call SP_SELECT_CART(?)', [
      req.signedCookies.uuid
    ]);

    // send to client
    let [cartNum, cartProduct] = dataCart;
    res.json([cartNum, cartProduct]);
  } catch (error) {
    next(error);
  }
};

module.exports.getCart = async (req, res, next) => {
  try {
    let dataSuggestion = await querySQL('call SP_SELECT_PRODUCT_SUGGESTION()');
    let sumPirce = await querySQL('call SP_GET_SUMPRICE_CART(?)', [
      req.signedCookies.uuid
    ]);
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
    cartInfo.unshift(req.signedCookies.uuid);
    cartInfo.push(sl);
    await querySQL('call SP_UPDATE_CART(?, ?, ?, ?, ?)', cartInfo);
    res.json({});
  } catch (error) {
    next(error);
  }
};

module.exports.getCartData = async (req, res, next) => {
  try {
    // let idUser = parseInt(req.params.idUser);
    let dataCart = await querySQL('call SP_SELECT_CART(?)', [
      req.signedCookies.uuid
    ]);
    let [cartNum, cartProduct] = dataCart;
    res.json([cartNum, cartProduct]);
  } catch (error) {
    next(error);
  }
};
