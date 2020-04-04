const { v4 } = require('uuid');
const querySQL = require('../configure/querySQL');

// get home
module.exports.getHome = (req, res, next) => {
  try {
    res.render('admin/index', {
      titleSite: 'ShopOH'
    });
  } catch (err) {
    next(err);
  }
};

// get product (all + filter + sort)
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
    let statusPro = req.query.status || '-1';
    let type = req.query.type || 'all';
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

    if (type === 'con') {
      products.forEach(pro => {
        pro.type = pro.type.filter(type => type.amount > 0);
      });
      products = products.filter(pro => pro.type.length > 0);
    } else if (type === 'het') {
      products.forEach(pro => {
        pro.type = pro.type.filter(type => type.amount === 0);
      });
      products = products.filter(pro => pro.type.length > 0);
    }

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

    // active tab main
    let productActive = '';
    if (statusPro === '-1') {
      productActive = 'all';
    } else if (statusPro === '2') {
      productActive = 'hide';
    }
    if (type === 'con') {
      productActive = 'con';
    } else if (type === 'het') {
      productActive = 'het';
    }

    res.render('admin/product', {
      titleSite: 'ShopOH',
      active: 'prolist',
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
      filterName,
      productActive,
      type
    });
  } catch (err) {
    next(err);
  }
};

// delete product
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

// get danh muc list
module.exports.getDanhMuc = async (req, res) => {
  try {
    let data = await querySQL('call ADMIN_SELECT_DANHMUC()');
    let danhMuc = data[0].map(itemL0 => {
      let l0 = { id: itemL0.ma_loai0, name: itemL0.ten_loai0, l1: [] };
      let l1s = data[1].filter(l1 => l1.ma_loai0 === itemL0.ma_loai0);
      l0.l1 = l1s.map(itemL1 => {
        let l1 = { id: itemL1.ma_loai1, name: itemL1.ten_loai1, l2: [] };
        let l2s = data[2].filter(l2 => l2.ma_loai1 === itemL1.ma_loai1);
        l1.l2 = l2s.map(itemL2 => {
          return { id: itemL2.ma_loai2, name: itemL2.ten_loai2 };
        });
        return l1;
      });
      return l0;
    });
    res.status(200).json(danhMuc);
  } catch (err) {
    res.sendStatus(400);
  }
};

module.exports.getAddProduct = async (req, res, next) => {
  try {
    let data = await querySQL('call ADMIN_SELECT_BRAND_MATERIAL()');
    let brands = data[0];
    let materials = data[1];
    res.render('admin/addproduct', {
      titleSite: 'ShopOH',
      active: 'addpro',
      brands,
      materials
    });
  } catch (err) {
    next(err);
  }
};
module.exports.postAddProduct = async (req, res) => {
  try {
    let name = req.body.nameProduct;
    // let loai0 = +req.body.loai0;
    // let loai1 = +req.body.loai1;
    let loai2 = +req.body.loai2;
    let describePro = req.body.describePro;
    let brand = +req.body.brand;
    let material = +req.body.material;
    let price = +req.body.price;
    let promotion = +req.body.promotion;
    let colors = req.body.color;
    let sizes = req.body.size;
    let amounts = req.body.amount;
    // let transportFee = +req.body.transportFee;
    let status = req.body.status;
    let imagePathJoin = req.files
      .map(file => `/images/products/${file.filename}`)
      .join(',');
    // generate id
    let id = v4();

    // insert product
    await querySQL('call ADMIN_INSERT_PRODUCT(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', [
      id,
      name,
      loai2,
      describePro,
      brand,
      material,
      price,
      promotion,
      status,
      imagePathJoin
    ]);

    // insert type product
    if (Array.isArray(colors)) {
      // has many type
      for (let i in colors) {
        await querySQL('call ADMIN_INSERT_TYPE_PRODUCT(?, ?, ?, ?)', [
          id,
          colors[i],
          sizes[i],
          amounts[i]
        ]);
      }
    } else {
      // only 1 type
      await querySQL('call ADMIN_INSERT_TYPE_PRODUCT(?, ?, ?, ?)', [
        id,
        colors,
        sizes,
        amounts
      ]);
    }
    res.sendStatus(200);
  } catch (err) {
    res.sendStatus(400);
  }
};
