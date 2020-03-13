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

    // format category;
    let category0 = data[0][0].ma_loai0 === 1 ? 'thoitrangnam' : 'thoitrangnu';
    let category1 = querystring.stringify({
      filterType1: data[0][0].ma_loai1
    });
    let category2 = querystring.stringify({
      filterType1: data[0][0].ma_loai1,
      filterType2: data[0][0].ma_loai2
    });

    // render
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
      category0, // category level 0 string query
      category1, // category level 1 string query
      category2 // category level 2 string query
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
    // get style (male or female)
    let { style } = req.params;

    if (style === 'thoitrangnam') {
      // STYLE MALE

      // get product
      let data = await querySQL('call SP_SELECT_PRODUCT_STYLE(?)', [1]);

      // render
      res.render('customer/maleProduct', {
        titleSite: 'ShopOH - Thời trang nam',
        products: data[0]
      });
    } else if (style === 'thoitrangnu') {
      // STYLE FEMALE

      // get product
      let data = await querySQL('call SP_SELECT_PRODUCT_STYLE(?)', [2]);

      // render
      res.render('customer/femaleProduct', {
        titleSite: 'ShopOH - Thời trang nữ',
        products: data[0]
      });
    }
  } catch (err) {
    next(err);
  }
};

// search (filter) by type
module.exports.searchStyle = async (req, res, next) => {
  try {
    let query = req.query, // get string query filter
      style = 0, // style (male: 1 or female: 2)
      title = '', // title site
      styleText = req.params.style; // style in text

    if (styleText === 'thoitrangnam') {
      // male style
      style = 1;
      title = 'ShopOH - Thời trang nam';
    } else if (styleText === 'thoitrangnu') {
      // female style
      style = 2;
      title = 'ShopOH - Thời trang nữ';
    }

    // format filter material
    if (!query.filterMaterial || query.filterMaterial === '') {
      query.filterMaterial = '-1';
    } else if (Array.isArray(query.filterMaterial)) {
      query.filterMaterial = query.filterMaterial.join(',');
    }

    // format filter type1
    if (!query.filterType1 || query.filterType1 === '') {
      query.filterType1 = '-1';
    }

    // format filter type1
    if (!query.filterType2 || query.filterType2 === '') {
      query.filterType2 = '-1';
    } else if (Array.isArray(query.filterType2)) {
      query.filterType2 = query.filterType2.join(',');
    }

    // format price range
    if (!query.minPriceRange) {
      query.minPriceRange = 0;
    } else {
      query.minPriceRange = +query.minPriceRange;
    }
    if (!query.maxPriceRange) {
      query.maxPriceRange = 0;
    } else {
      query.maxPriceRange = +query.maxPriceRange;
    }

    // format sort by
    if (!query.sortBy || query.sortBy === 'new') {
      query.sort = 'sp.ngaythem desc';
      query.sortBy = 'new';
    } else if (query.sortBy === 'selling') {
      query.sort = 'sp.daban desc';
    } else if (query.sortBy === 'price-increase') {
      query.sort = '(sp.giaban * (1 - sp.khuyenmai / 100)) asc';
    } else if (query.sortBy === 'price-decease') {
      query.sort = '(sp.giaban * (1 - sp.khuyenmai / 100)) desc';
    }

    // get product filter
    let data = await querySQL('call SP_SEARCH_STYLE(?, ?, ?, ?, ?, ?, ?)', [
      style, // style formated
      query.filterType1, // type1 formated
      query.filterType2, // type2 formated
      query.filterMaterial, // material formated
      query.minPriceRange, // min price range formated
      query.maxPriceRange, // max price range formated
      query.sort // sort by formated
    ]);

    // Check being filter by type1?
    if (query.filterType1 !== '-1') {
      // No

      // render substyle view (type2)
      res.render('customer/subStyleProduct', {
        titleSite: title,
        products: data[0],
        query // save filter value
      });
    } else {
      // Yes

      // render style view (type1)
      res.render('customer/styleProduct', {
        titleSite: title,
        products: data[0],
        query // save filter value
      });
    }
  } catch (err) {
    next(err);
  }
};
