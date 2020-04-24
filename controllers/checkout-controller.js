const jwt = require('jsonwebtoken');
const { v4 } = require('uuid');
const querySQL = require('../configure/querySQL');
const { myEncode, myDecode } = require('../configure/myEncode');

// get token checkout
module.exports.getToken = async (req, res) => {
  try {
    // get list item checkout
    let { item } = req.query;

    // check each item
    if (!Array.isArray(item)) {
      item = [item];
    }
    // products
    let products = [];
    for (let it of item) {
      let params = it.split('$');
      let data = await querySQL(
        'call CHECK_PRODUCT_CHECKOUT(?, ?, ?, ?)',
        params
      );
      // not exists item
      if (!data[0][0]) {
        return res.sendStatus(400);
      }
      products.push(data[0][0]);
    }

    // pass check item list
    let token = jwt.sign({ items: products }, process.env.CHECKOUT_SECRET);

    // send token to client
    res.status(200).json({ token });
  } catch (err) {
    res.sendStatus(400);
  }
};

// get checkout
module.exports.getCheckout = async (req, res, next) => {
  try {
    // get token checkout
    let { token } = req.query;

    // verify token and if pass then get items
    let { items } = jwt.verify(token, process.env.CHECKOUT_SECRET);

    // calculator sum price of items
    let sumPrice = 0;
    for (let item of items) {
      sumPrice +=
        Math.round(item.giaban * (1 - item.khuyenmai / 100)) * item.sl;
    }

    //get address of user
    let data = await querySQL('call SELECT_ADDRESS(?)', [req.userId]);
    let addrs = data[0];
    for (let addr of addrs) {
      addr.encode = myEncode(addr.ma_diachi);
    }

    // get address default
    let addrDefault = addrs.find((addr) => addr.macdinh);

    // render
    res.render('customer/checkout', {
      titleSite: 'ShopOH - Checkout',
      items,
      sumPrice,
      addrs,
      addrDefault,
    });
  } catch (err) {
    res.redirect('/cart');
  }
};

// post checkout
module.exports.postCheckout = async (req, res) => {
  try {
    // get token and address order
    let { token, address } = req.body;
    // decode address
    address = myDecode(address);
    // versify token and get items
    let { items } = jwt.verify(token, process.env.CHECKOUT_SECRET);
    // generate id order
    let idOrder = v4();

    // get address
    let data = await querySQL('call SELECT_INFO_ADDRESS(?, ?)', [
      req.userId,
      address,
    ]);
    let addr = data[0][0];
    // create order in db
    await querySQL('call CREATE_ORDER(?, ?)', [req.userId, idOrder]);
    // add address to order
    await querySQL('call INSERT_ADDRESS_ORDER(?, ?, ?, ?, ?, ?, ?)', [
      idOrder,
      addr.ten,
      addr.dienthoai,
      addr.tinh,
      addr.huyen,
      addr.xa,
      addr.nha,
    ]);
    // insert items to order
    for (let item of items) {
      await querySQL('call INSERT_ORDER(?, ?, ?, ?, ?, ?, ?)', [
        idOrder,
        item.ma_sanpham,
        item.mausac,
        item.size,
        item.sl,
        item.giaban,
        item.khuyenmai,
      ]);
    }
    // OK
    res.sendStatus(200);
  } catch (err) {
    res.sendStatus(400);
  }
};
