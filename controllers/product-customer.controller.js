const querystring = require('querystring');

// configure
const querySQL = require('../configure/querySQL');

module.exports.getIndex = async (req, res, next) => {
  try {
    let data = await querySQL('call SP_SELECT_PRODUCT_SUGGESTION()');
    let dataCart = await querySQL('call SP_SELECT_CART(?)', [1]);
    res.render('customer/index', { 
      title: 'ShopOP',
      productList: data[0],
      cartNum: dataCart[0][0],
      cartProduct: dataCart[1]
    });
  } catch(err) {
    next(err);
  }
};

module.exports.getProducts = async (req, res, next) => {
  try {
    let queryReq = req.query;
    let data = null;
    if (queryReq.hasOwnProperty('id')) {
      data = await querySQL('call SP_SELECT_SAMEPRODUCT (?, ?, ?)', [queryReq.id, queryReq.category, queryReq.material]);
      let dataCart = await querySQL('call SP_SELECT_CART(?)', [1]);
      res.render('customer/same-product', {
        title: 'ShopOP - Sản phẩm',
        productMain: data[0][0],
        productSameList: data[1],
        cartNum: dataCart[0][0],
        cartProduct: dataCart[1]
      });
    } else {
      data = await querySQL('call SP_SELECT_PRODUCT_ALL()')
      let dataCart = await querySQL('call SP_SELECT_CART(?)', [1]);
      res.render('customer/allproduct', {
        titleSite: 'ShopOP - Sản phẩm',
        productList: data[0],
        cartNum: dataCart[0][0],
        cartProduct: dataCart[1]
      });
    }
  } catch(err) {
    next(err);
  }
};

module.exports.getProduct = async (req, res, next) => {
  try {
    let idProduct = parseInt(req.params.idProduct);
    let data = await querySQL('call SP_SELECT_PRODUCT(?, ?)', [idProduct, 1]);
    let dataCart = await querySQL('call SP_SELECT_CART(?)', [1]);
    res.render('customer/product', { 
      titleSite: 'ShopOP - Sản phẩm',
      product: data[0][0],
      urlImgs: data[0][0].hinhanh.split(','),
      colorList: data[1],
      sizeList: data[2],
      amount: data[3][0],
      like: data[4][0],
      isLike: data[5][0],
      productSameList: data[6],
      category0: querystring.stringify({level: 0, category: data[0][0].ma_loai0}),
      category1: querystring.stringify({level: 1, category: data[0][0].ma_loai1}),
      category2: querystring.stringify({level: 2, category: data[0][0].ma_loai2}),
      cartNum: dataCart[0][0],
      cartProduct: dataCart[1]
    });
  } catch(err) {
    next(err);
  }
};

module.exports.getAmountProduct = async (req, res, next) => {
  try {
    let idProduct = parseInt(req.params.idProduct);
    let colorProduct = req.params.color;
    let sizeProduct = req.params.size;

    let data = await querySQL('call SP_SELECT_MOUNT_PRODUCT (?, ?, ?)', [idProduct, colorProduct, sizeProduct]);

    res.send(data[0][0]);
  } catch(err) {
    next(err);
  }
};

module.exports.postAddLike = async (req, res, next) => {
  try {
    let idProduct = parseInt(req.params.idProduct);

    let data = await querySQL('call SP_ADDLIKE (?, ?)', [idProduct, 1]);

    res.send(data[0][0]);
  } catch(err) {
    next(err);
  }
};

module.exports.deleteLike = async (req, res, next) => {
  try {
    let idProduct = parseInt(req.params.idProduct);

    let data = await querySQL('call SP_DELETELIKE(?, ?)', [idProduct, 1]);

    res.send(data[0][0]);
  } catch(err) {
    next(err);
  }
};

module.exports.getStyle = async (req, res, next) => {
  try {
    let styleText = req.params.style;
    let style = 0;
    if (styleText === 'thoitrangnam') {
      style = 1;
      res.render('customer/maleProduct', {
        titleSite: 'ShopOH - Thời trang nam'
      })
    } else if (styleText === 'thoitrangnu') {
      style = 2;
    }

    let data = await querySQL('call SP_SELECT_PRODUCT_STYLE(?)', [style]);

    // res.json(data[0]);
  } catch(err) {
    next(err);
  }
};