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
    // get req filter
    let typeFilterName = req.query.typeFilterName || 'name';
    let filterName = req.query.filterName || '-1';
    let filterPriceMin = +req.query.filterPriceMin || 0;
    let filterPriceMax = +req.query.filterPriceMax || 0;
    let loai0 = +req.query.loai0 || -1;
    let loai1 = +req.query.loai1 || -1;
    let loai2 = +req.query.loai2 || -1;
    let filterSelledMin = +req.query.filterSelledMin || 0;
    let filterSelledMax = +req.query.filterSelledMax || 0;
    let statusPro = req.query.statusPro || '-1';

    // get data product from db
    let data = await querySQL(
      'call ADMIN_SELECT_PRODUCT(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [
        typeFilterName,
        filterName,
        filterPriceMin,
        filterPriceMax,
        loai0,
        loai1,
        loai2,
        filterSelledMin,
        filterSelledMax,
        statusPro
      ]
    );

    //get req sort
    let typeSort = req.query.sortType || 'time';
    let valueSort = req.query.sortValue || 'decrease';

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
      product.dateAdd = new Date(pro.ngaythem);
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
    // if (filterName !== '-1') {
    //   if (typeFilterName === 'name') {
    //   } else if (typeFilterName === 'id') {
    //     let pro = products.find(pro => pro.id === filterName);
    //     if (pro) {
    //       products = [pro];
    //     } else {
    //       products = [];
    //     }
    //   }
    // }

    // sort products
    // sort default: time decrease
    if (typeSort === 'time') {
      // sort by time
      if (valueSort === 'increase') {
        products.sort((a, b) => a.dateAdd - b.dateAdd);
      }
    } else if (typeSort === 'price') {
      // sort by price
      if (valueSort === 'increase') {
        products.sort((a, b) => a.price - b.price);
      } else if (valueSort === 'decrease') {
        products.sort((a, b) => b.price - a.price);
      }
    } else if (typeSort === 'selled') {
      // sort by selles
      if (valueSort === 'increase') {
        products.sort((a, b) => a.selled - b.selled);
      } else if (valueSort === 'decrease') {
        products.sort((a, b) => b.selled - a.selled);
      }
    } else if (typeSort === 'like') {
      // sort by like
      if (valueSort === 'increase') {
        products.sort((a, b) => a.like - b.like);
      } else if (valueSort === 'decrease') {
        products.sort((a, b) => b.like - a.like);
      }
    }

    res.render('admin/product', {
      titleSite: 'ShopOH',
      products,
      typeSort,
      valueSort,
      statusPro,
      filterPriceMin,
      filterPriceMax,
      loai0,
      loai1,
      loai2,
      filterSelledMin,
      filterSelledMax,
      typeFilterName,
      filterName
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
