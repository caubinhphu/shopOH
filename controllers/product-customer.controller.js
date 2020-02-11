// configure
const querySQL = require('../configure/querySQL');

module.exports.getIndex = async (req, res, next) => {
  try {
    let data = await querySQL('select ma_sanpham, ten_sanpham, giaban, `like`, ma_loai2, hinhanh, ma_chatlieu from sanpham limit 10');
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
        title: 'ShopOP - Sản phẩm',
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
    let data = await querySQL('call SP_SELECT_PRODUCT(?)', [idProduct]);
    res.render('customer/product', { 
      title: 'ShopOP - Sản phẩm',
      product: data[0],
      productSameList: data[1]
    });
  } catch(err) {
    next(err);
  }
};