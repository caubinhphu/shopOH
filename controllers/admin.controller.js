const querySQL = require('../configure/querySQL');

module.exports.getHome = (req, res, next) => {
  try {
    res.render('admin/index', {
      titleSite: 'ShopOH'
    });
  } catch (err) {
    next(err);
  }
};

module.exports.getProduct = async (req, res, next) => {
  try {
    let data = await querySQL('call ADMIN_SELECT_PRODUCT()');

    let products = [];
    data[0].forEach(pro => {
      // create product obj
      let product = {};
      product.id = pro.ma_sanpham;
      product.name = pro.ten_sanpham;
      product.img = pro.hinhanh.split(',')[0];
      product.selled = pro.daban;
      product.price = pro.giaban;
      product.promotion = pro.khuyenmai;
      product.type = [];
      // get type of product
      for (let pro of data[1]) {
        if (pro.ma_sanpham === product.id) {
          let type = {};
          type.color = pro.mausac;
          type.size = pro.size;
          type.amount = pro.soluongton;
          product.type.push(type);
        }
      }
      // get like of product
      let likePro = data[2].find(pro => pro.ma_sanpham === product.id);
      if (likePro) {
        product.like = likePro.solike;
      } else {
        product.like = 0;
      }
      products.push(product);
    });
    res.render('admin/product', {
      titleSite: 'ShopOH',
      products
    });
  } catch (err) {
    next(err);
  }
};

module.exports.deleteProduct = async (req, res) => {
  try {
    // get id product
    let { idPro } = req.params;
    await querySQL('call ADMIN_DELETE_PRODUCT(?)', [idPro]);
    res.sendStatus(200);
  } catch (err) {
    res.sendStatus(400);
  }
};
