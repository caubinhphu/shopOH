const querySQL = require('../configure/querySQL');
const { myEncode, myDecode } = require('../configure/myEncode');

// remove product in cart
module.exports.deleteCart = async (req, res, next) => {
  try {
    // get info product want remove
    let cartInfo = myDecode(req.body.info).split('$');
    cartInfo.unshift(req.userId); // unshift current user

    // remove product from cart
    await querySQL('call SP_DELETE_CART(?, ?, ?, ?)', cartInfo);

    // get new cart after remove product from cart
    let dataCart = await querySQL('call SP_SELECT_CART(?)', [req.userId]);
    let cartNum = dataCart[0][0],
      cartProduct = dataCart[1];

    // add field encode to cartProduct
    for (let item of cartProduct) {
      item.encode = myEncode(
        item.ma_sanpham.concat('$', item.mausac, '$', item.size)
      );
    }

    // send to client
    res.status(200).json({ cartNum, cartProduct });
  } catch (error) {
    res.sendStatus(400);
  }
};

// add product to the cart
module.exports.postAddCart = async (req, res, next) => {
  try {
    // get info post from client
    let data = req.body;

    // add product to the cart
    await querySQL('call SP_INSERT_CART(?, ?, ?, ?, ?)', [
      data.idPro, // id product
      req.userId, // current user
      data.color, // color product
      data.size, // size product
      data.quantity, // quantity
    ]);

    // get new cart after add product
    let dataCart = await querySQL('call SP_SELECT_CART(?)', [req.userId]);
    let cartNum = dataCart[0][0],
      cartProduct = dataCart[1];

    // add field encode to cartProduct
    for (let item of cartProduct) {
      item.encode = myEncode(
        item.ma_sanpham.concat('$', item.mausac, '$', item.size)
      );
    }

    // send to client
    res.status(200).json({ cartNum, cartProduct });
  } catch (error) {
    res.sendStatus(400);
  }
};

// get cart index
module.exports.getCart = async (req, res, next) => {
  try {
    // get products suggestion
    let dataSuggestion = await querySQL('call SP_SELECT_PRODUCT_SUGGESTION()');

    // get sum price product in cart
    let sumPirce = await querySQL('call SP_GET_SUMPRICE_CART(?)', [req.userId]);

    // render
    res.render('customer/cart', {
      titleSite: 'ShopOH - Giỏ hàng',
      sumPrice: sumPirce[0][0], // sum price in cart
      productSuggestionList: dataSuggestion[0], // products suggestion
    });
  } catch (error) {
    next(error);
  }
};

// change (put) amount of product in cart
module.exports.putCart = async (req, res, next) => {
  try {
    // get product data from client and decode
    let cartInfo = myDecode(req.body.info).split('$');

    // get amount want to put
    let sl = req.body.sl;

    // add userId to cart info
    cartInfo.unshift(req.userId);

    // add amount want to put to cart info
    cartInfo.push(sl);

    // put cart
    await querySQL('call SP_UPDATE_CART(?, ?, ?, ?, ?)', cartInfo);

    // send Ok status to client
    res.sendStatus(200);
  } catch (error) {
    res.sendStatus(400);
  }
};

// get data for mini cart
module.exports.getCartData = async (req, res, next) => {
  try {
    // get data cart
    let dataCart = await querySQL('call SP_SELECT_CART(?)', [req.userId]);

    // get cartNum (slsp: sum product, sl: sum type product) and cartProduct (products in cart)
    let cartNum = dataCart[0][0],
      cartProduct = dataCart[1];

    // add field encode to cartProduct
    for (let item of cartProduct) {
      item.encode = myEncode(
        item.ma_sanpham.concat('$', item.mausac, '$', item.size)
      );
    }

    // send data to client
    // res.json([cartNum, cartProduct]);
    res.status(200).json({ cartNum, cartProduct });
  } catch (error) {
    res.sendStatus(400);
  }
};
