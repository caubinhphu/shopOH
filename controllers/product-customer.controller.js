const querystring = require('querystring');

// query SQL function
const querySQL = require('../configure/querySQL');

// home page
module.exports.getIndex = async (req, res, next) => {
  try {
    // lấy sản phẩm gợi ý trong ngày
    let data = await querySQL('call SP_SELECT_PRODUCT_SUGGESTION()');
    // render pug
    res.render('customer/index', {
      title: 'ShopOP',
      productList: data[0] // danh sách sản phẩm gợi ý
    });
  } catch (err) {
    next(err);
  }
};

// get all products or main + same-product
module.exports.getProducts = async (req, res, next) => {
  try {
    //get query string
    let queryReq = req.query;

    // data product
    let data = null;
    if (queryReq.hasOwnProperty('id')) {
      // HAS QUERY STRING => MAIN + SAME-PRODUCT
      // get data
      data = await querySQL('call SP_SELECT_SAMEPRODUCT (?, ?, ?)', [
        queryReq.id, // id main product
        queryReq.category, // category main product
        queryReq.material // material main product
      ]);

      // render pug
      res.render('customer/same-product', {
        title: 'ShopOP - Sản phẩm',
        productMain: data[0][0], // data main product
        productSameList: data[1] // data same-product list
      });
    } else {
      // NO QUERY STRING => GET ALL PRODUCT
      // get data
      data = await querySQL('call SP_SELECT_PRODUCT_ALL()');

      // render pug
      res.render('customer/allproduct', {
        titleSite: 'ShopOP - Sản phẩm',
        productList: data[0] // all data product
      });
    }
  } catch (err) {
    next(err);
  }
};

// get info a product + same-product
module.exports.getProduct = async (req, res, next) => {
  try {
    // get id main product
    let { idProduct } = req.params;

    // get info main product
    let data = await querySQL('call SP_SELECT_PRODUCT(?, ?)', [idProduct, '1']);
    res.render('customer/product', {
      titleSite: 'ShopOH - Sản phẩm',
      product: data[0][0], // info main product
      urlImgs: data[0][0].hinhanh.split(','), // path image main product
      colorList: data[1], // color main product list
      sizeList: data[2], // size main product list
      amount: data[3][0], // amount main product in stored
      like: data[4][0], // amount like of main product
      isLike: data[5][0], // current user is liked main product?
      productSameList: data[6], // same product list
      category0: querystring.stringify({
        level: 0,
        category: data[0][0].ma_loai0
      }), // create category level 0 string query
      category1: querystring.stringify({
        level: 1,
        category: data[0][0].ma_loai1
      }), // create category level 1 string query
      category2: querystring.stringify({
        level: 2,
        category: data[0][0].ma_loai2
      }) // create category level 2 string query
    });
  } catch (err) {
    next(err);
  }
};

// get amount product in stored
module.exports.getAmountProduct = async (req, res, next) => {
  try {
    // get params product
    let { idProduct, color, size } = req.query; // get id, color, size product

    // get amount product
    let data = await querySQL('call SP_SELECT_MOUNT_PRODUCT (?, ?, ?)', [
      idProduct, // id product
      color, // color product
      size // size product
    ]);

    // send data to client
    let dataSend = data[0][0] || { soluongton: 0 };
    res.json(dataSend);
  } catch (err) {
    next(err);
  }
};

// add like
module.exports.postAddLike = async (req, res, next) => {
  try {
    // get id product
    let { idProduct } = req.params;

    // add like anh return amount like
    let data = await querySQL('call SP_ADDLIKE (?, ?)', [idProduct, '1']);

    // send amount like to client
    res.json(data[0][0]);
  } catch (err) {
    next(err);
  }
};

// remove like
module.exports.deleteLike = async (req, res, next) => {
  try {
    // get id product
    let { idProduct } = req.params;

    // remove like and return amount like
    let data = await querySQL('call SP_DELETELIKE(?, ?)', [idProduct, 1]);

    // send amount like to client
    res.json(data[0][0]);
  } catch (err) {
    next(err);
  }
};

// style product (male + female)
module.exports.getStyle = async (req, res, next) => {
  try {
    let { style } = req.params;
    if (style === 'thoitrangnam') {
      let data = await querySQL('call SP_SELECT_PRODUCT_STYLE(?)', [1]);
      res.render('customer/maleProduct', {
        titleSite: 'ShopOH - Thời trang nam',
        products: data[0]
      });
    } else if (style === 'thoitrangnu') {
      let data = await querySQL('call SP_SELECT_PRODUCT_STYLE(?)', [2]);
      res.render('customer/femaleProduct', {
        titleSite: 'ShopOH - Thời trang nữ',
        products: data[0]
      });
    }
  } catch (err) {
    next(err);
  }
};

module.exports.searchStyle = async (req, res, next) => {
  try {
    let query = req.query,
      style = 0,
      title = '',
      styleText = req.params.style;
    if (styleText === 'thoitrangnam') {
      style = 1;
      title = 'ShopOH - Thời trang nam';
    } else if (styleText === 'thoitrangnu') {
      style = 2;
      title = 'ShopOH - Thời trang nữ';
    }

    if (!query.filterMaterial || query.filterMaterial === '') {
      query.filterMaterial = '-1';
    } else if (Array.isArray(query.filterMaterial)) {
      query.filterMaterial = query.filterMaterial.join(',');
    }

    if (!query.filterType1 || query.filterType1 === '') {
      query.filterType1 = '-1';
    }

    if (!query.filterType2 || query.filterType2 === '') {
      query.filterType2 = '-1';
    } else if (Array.isArray(query.filterType2)) {
      query.filterType2 = query.filterType2.join(',');
    }

    query.minPriceRange = +query.minPriceRange;
    query.maxPriceRange = +query.maxPriceRange;

    let data = await querySQL('call SP_SEARCH_STYLE(?, ?, ?, ?, ?, ?)', [
      style,
      query.filterType1,
      query.filterType2,
      query.filterMaterial,
      query.minPriceRange,
      query.maxPriceRange
    ]);

    if (query.filterType1 !== '-1') {
      res.render('customer/subStyleProduct', {
        titleSite: title,
        products: data[0],
        query
      });
    } else {
      res.render('customer/styleProduct', {
        titleSite: title,
        products: data[0],
        query
      });
    }
  } catch (err) {
    next(err);
  }
};
