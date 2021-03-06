const querystring = require('querystring');

// product / page
const productPerPage = 36;

// function generate page array
const generatePageArr = function(pageCur, pageMax) {
  // init array
  let pageArr = [pageCur - 2, pageCur - 1, pageCur, pageCur + 1, pageCur + 2];

  // validate array
  pageArr = pageArr.filter(
    p => p * productPerPage <= pageMax * productPerPage && p > 0
  );

  // case special
  if (pageCur === 1) {
    if (pageCur + 3 <= pageMax) {
      pageArr.push(pageCur + 3);
      if (pageCur + 4 <= pageMax) {
        pageArr.push(pageCur + 4);
      }
    }
  } else if (pageCur === 2) {
    if (pageCur + 3 <= pageMax) {
      pageArr.push(pageCur + 3);
    }
  } else if (pageCur === pageMax - 1) {
    if (pageCur - 3 > 0) {
      pageArr.unshift(pageCur - 3);
    }
  } else if (pageCur === pageMax) {
    if (pageCur - 3 > 0) {
      pageArr.unshift(pageCur - 3);
      if (pageCur - 4 > 0) {
        pageArr.unshift(pageCur - 4);
      }
    }
  }

  return pageArr;
};

// query SQL function
const querySQL = require('../configure/querySQL');

// home page
module.exports.getIndex = async (req, res, next) => {
  try {
    // lấy sản phẩm gợi ý trong ngày
    let data = await querySQL('call SP_SELECT_PRODUCT_SUGGESTION()');
    // render pug
    res.render('customer/index', {
      titleSite: 'ShopOH',
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
    let queryReq = req.query,
      page = +queryReq.page || 1, // current page, default 1
      offset = (page - 1) * productPerPage;

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

      let sumProductSame = data[1].length,
        pageMax = Math.ceil(sumProductSame / productPerPage),
        pageArr = generatePageArr(page, pageMax),
        sameProducts = data[1].slice(offset, productPerPage + offset);

      // render pug
      res.render('customer/same-product', {
        titleSite: 'ShopOH - Sản phẩm',
        productMain: data[0][0], // data main product
        sameProducts, // data same-product list
        pageMax, // page max
        sumProductSame, // sum product same
        page, // page current
        productPerPage, // product per page
        pageArr // page array
      });
    } else {
      // NO QUERY STRING => GET ALL PRODUCT
      // get data
      data = await querySQL('call SP_SELECT_PRODUCT_ALL(?, ?)', [
        offset, // offset limit
        productPerPage // limit
      ]);

      let sumProduct = data[1][0].tong, // sum product
        pageMax = Math.ceil(sumProduct / productPerPage); // page max

      let pageArr = generatePageArr(page, pageMax);
      // render pug
      res.render('customer/allproduct', {
        titleSite: 'ShopOH - Sản phẩm',
        products: data[0], // all data product
        page, // page current
        pageArr, // page array
        pageMax, // page max
        productPerPage, // product per page
        sumProduct // sum product
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

    let idUser = req.userId || '-1';

    // get info main product
    let data = await querySQL('call SP_SELECT_PRODUCT(?, ?)', [
      idProduct,
      idUser
    ]);

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

// modify like
module.exports.postAddLike = async (req, res, next) => {
  try {
    // get id product
    let { idProduct } = req.params;

    // add like anh return amount like
    let data = await querySQL('call MODIFY_LIKE (?, ?)', [
      idProduct,
      req.userId
    ]);

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
    let page = +req.query.page || 1, // current page, default 1
      offset = (page - 1) * productPerPage;

    if (style === 'thoitrangnam') {
      // STYLE MALE

      // get product
      let data = await querySQL('call SP_SELECT_PRODUCT_STYLE(?, ?, ?)', [
        1, // style
        offset, // offset limit
        productPerPage // limit
      ]);

      let sumProduct = data[1][0].tong,
        pageMax = Math.ceil(sumProduct / productPerPage),
        pageArr = generatePageArr(page, pageMax);

      // render
      res.render('customer/maleProduct', {
        titleSite: 'ShopOH - Thời trang nam',
        products: data[0],
        page, // page current
        productPerPage, // product per page
        pageArr, // page array
        pageMax, // page max
        sumProduct // sum product satisfy condition
      });
    } else if (style === 'thoitrangnu') {
      // STYLE FEMALE

      // get product
      let data = await querySQL('call SP_SELECT_PRODUCT_STYLE(?, ?, ?)', [
        2, // style
        offset, // offset limit
        productPerPage // limit
      ]);

      let sumProduct = data[1][0].tong,
        pageMax = Math.ceil(sumProduct / productPerPage),
        pageArr = generatePageArr(page, pageMax);

      // render
      res.render('customer/femaleProduct', {
        titleSite: 'ShopOH - Thời trang nữ',
        products: data[0],
        page, // page current
        productPerPage, // prodcut per page
        pageArr, // page array
        pageMax, // page max
        sumProduct // sum product satisfy condition
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
      titleSite = '', // title site
      styleText = req.params.style, // style in text
      page = +query.page || 1,
      offset = (page - 1) * productPerPage;

    if (styleText === 'thoitrangnam') {
      // male style
      style = 1;
      titleSite = 'ShopOH - Thời trang nam';
    } else if (styleText === 'thoitrangnu') {
      // female style
      style = 2;
      titleSite = 'ShopOH - Thời trang nữ';
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

    let sumProduct = data[0].length,
      pageMax = Math.ceil(sumProduct / productPerPage),
      pageArr = generatePageArr(page, pageMax),
      products = data[0].slice(offset, offset + productPerPage);

    // Check being filter by type1?
    if (query.filterType1 !== '-1') {
      // No

      // render substyle view (type2)
      res.render('customer/subStyleProduct', {
        titleSite,
        products,
        query, // save filter value
        page, // page current
        pageArr, // page array
        sumProduct, // sum product
        productPerPage, // product per page
        pageMax // page max
      });
    } else {
      // Yes

      // render style view (type1)
      res.render('customer/styleProduct', {
        titleSite,
        products,
        query, // save filter value
        page, // page current
        pageArr, // page array
        sumProduct, // sum product
        productPerPage, // product per page
        pageMax // page max
      });
    }
  } catch (err) {
    next(err);
  }
};

module.exports.searchProduct = async (req, res, next) => {
  try {
    // get keyword search
    let { keyword } = req.query,
      page = +req.query.page || 1,
      offset = (page - 1) * productPerPage;

    // slice 100 chars start keyword string
    keyword = keyword.slice(0, 100);

    // convert keyword into array
    let keywordArr = keyword.split(' ');

    // get all product
    let data = await querySQL('call SP_SELECT_PRODCUT_FOR_SEARCH()');
    let products = data[0];

    // get info product serve for search (merge into string)
    let mapping = products.map(pro => {
      pro.search = pro.ten_sanpham.concat(
        ' ',
        pro.ten_thuonghieu,
        ' ',
        pro.ten_chatlieu,
        ' ',
        pro.ten_loai2,
        ' ',
        pro.ten_loai1,
        ' ',
        pro.ten_loai0
      ); // add field search
      pro.count = 0; // add field count word same with keyword
      return pro;
    });

    let mapFilter = mapping.filter(pro => {
      let strArr = pro.search.split(' ');
      // compare base word - word
      for (let str of strArr) {
        for (let key of keywordArr) {
          // compare locale base
          if (str.localeCompare(key, 'en', { sensitivity: 'base' }) === 0) {
            pro.count++;
          }
        }
      }
      return pro.count > 0;
    });

    // sort desc count word same with keyword
    mapFilter.sort((a, b) => b.count - a.count);

    let sumProduct = mapFilter.length,
      pageMax = Math.ceil(sumProduct / productPerPage),
      pageArr = generatePageArr(page, pageMax);

    mapFilter = mapFilter.slice(offset, offset + productPerPage);

    res.render('customer/searchProduct', {
      titleSite: 'Shop OH - Search',
      products: mapFilter, // product search
      page, // page current
      productPerPage, // product per page
      pageArr, // page array
      pageMax, // page max
      keyword, // key word search
      sumProduct // sum product
    });
  } catch (err) {
    next(err);
  }
};
