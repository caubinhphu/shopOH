const querystring = require('querystring');

// configure
const querySQL = require('../configure/querySQL');

module.exports.getIndex = async (req, res, next) => {
  try {
    let data = await querySQL('select ma_sanpham, ten_sanpham, giaban, khuyenmai, `like`, ma_loai2, hinhanh, ma_chatlieu from sanpham limit 10');
    res.render('customer/index', { 
      title: 'ShopOP',
      productList: data
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
      res.render('customer/same-product', {
        title: 'ShopOP - Sản phẩm',
        productMain: data[0][0],
        productSameList: data[1]
      });
    } else {
      data = await querySQL('select ma_sanpham, ten_sanpham, giaban, `like`, ma_loai2, hinhanh, ma_chatlieu from sanpham')
      res.render('customer/allproduct', {
        titleSite: 'ShopOP - Sản phẩm',
        productList: data
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
    res.render('customer/product', { 
      titleSite: 'ShopOP - Sản phẩm',
      product: data[0][0],
      colorList: data[1],
      sizeList: data[2],
      amount: data[3][0],
      like: data[4][0],
      isLike: data[5][0],
      productSameList: data[6],
      category0: querystring.stringify({cate0: data[0][0].ten_loai0}),
      category1: querystring.stringify({cate0: data[0][0].ten_loai0, cate1: data[0][0].ten_loai1}),
      category2: querystring.stringify({cate0: data[0][0].ten_loai0, cate1: data[0][0].ten_loai1, cate2: data[0][0].ten_loai2})
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