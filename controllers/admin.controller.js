const { v4 } = require('uuid');
const fs = require('fs');
const path = require('path');
const moment = require('moment');
const xlsx = require('xlsx');
const querySQL = require('../configure/querySQL');

// get home
module.exports.getHome = async (req, res, next) => {
  try {
    // get data statistical
    let data = await querySQL('call ADMIN_STATISTICAL_INDEX()');

    let orderStatistical = data[0];
    let proHideStatistical = data[1][0];
    let proHetStatistical = data[2][0];

    // render
    res.render('admin/index', {
      titleSite: 'ShopOH',
      orderStatistical,
      proHideStatistical,
      proHetStatistical,
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
        typeFilterName, // filter type name (by id or by name)
        filterName, // filter name (id or name)
        filterPriceMin, // filter price min
        filterPriceMax, // filter price max
        loai0, // filter id caterfory 0
        loai1, // filter id caterfory 1
        loai2, // filter id caterfory 2
        filterSelledMin, // filter selles min
        filterSelledMax, // filter selles max
        statusPro, // filter status product
      ]
    );

    //get req sort
    let typeSort = req.query.sortType || 'time';
    let valueSort = req.query.sortValue || 'decrease';

    // create product list
    let products = [];
    data[0].forEach((pro) => {
      // create a product obj
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
      let likePro = data[2].find((pro) => pro.ma_sanpham === product.id);
      if (likePro) {
        product.like = likePro.solike;
      } else {
        product.like = 0;
      }
      products.push(product);
    });

    // filter products by type (còn hàng, hết hàng)
    if (type === 'con') {
      products.forEach((pro) => {
        pro.type = pro.type.filter((type) => type.amount > 0);
      });
      products = products.filter((pro) => pro.type.length > 0);
    } else if (type === 'het') {
      products.forEach((pro) => {
        pro.type = pro.type.filter((type) => type.amount === 0);
      });
      products = products.filter((pro) => pro.type.length > 0);
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

    // render
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
      type,
      successMgs: req.flash('success_mgs'),
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

    // delete product and return img string of this product
    let data = await querySQL('call ADMIN_DELETE_PRODUCT(?)', [idPro]);

    // get img string
    let imgs = data[0][0].hinhanh.split(',');

    // remove img
    imgs.forEach((img) => {
      fs.unlink(path.join(__dirname, '..', 'public', img), (errUnlink) => {
        if (errUnlink) {
          throw errUnlink;
        }
      });
    });
    // send status OK
    res.sendStatus(200);
  } catch (err) {
    res.sendStatus(400);
  }
};

// get danh muc list
module.exports.getDanhMuc = async (req, res) => {
  try {
    // get danh muc, include: loai0s, loai1s, loai2s
    let data = await querySQL('call ADMIN_SELECT_DANHMUC()');

    // create danh muc list form data above
    let danhMuc = data[0].map((itemL0) => {
      // ceate l0 obj, include: id, name, l1 array
      let l0 = { id: itemL0.ma_loai0, name: itemL0.ten_loai0, l1: [] };

      // filter l1s belong l0 above
      let l1s = data[1].filter((l1) => l1.ma_loai0 === itemL0.ma_loai0);

      // create l1 array of l0 above by away mapping l1s
      l0.l1 = l1s.map((itemL1) => {
        // ceate l1 obj, include: id, name, l2 array
        let l1 = { id: itemL1.ma_loai1, name: itemL1.ten_loai1, l2: [] };

        // filter l2s belong l1 above
        let l2s = data[2].filter((l2) => l2.ma_loai1 === itemL1.ma_loai1);

        // create l2 array of l1 above by away mapping ls2
        l1.l2 = l2s.map((itemL2) => {
          // return l2 obj, include: id, name
          return { id: itemL2.ma_loai2, name: itemL2.ten_loai2 };
        });

        // return l1 obj
        return l1;
      });

      // return l0 obj
      return l0;
    });

    // send status OK anh danhmuc list
    res.status(200).json(danhMuc);
  } catch (err) {
    res.sendStatus(400);
  }
};

// get add product
module.exports.getAddProduct = async (req, res, next) => {
  try {
    // get brands and matreials form db
    let data = await querySQL('call ADMIN_SELECT_BRAND_MATERIAL()');
    let brands = data[0];
    let materials = data[1];

    // render
    res.render('admin/addproduct', {
      titleSite: 'ShopOH',
      active: 'addpro',
      brands,
      materials,
    });
  } catch (err) {
    next(err);
  }
};

// post add product
module.exports.postAddProduct = async (req, res) => {
  try {
    // get data form req.body
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

    // get path files upload and join into string path join
    let imagePathJoin = req.files
      .map((file) => `/images/products/${file.filename}`)
      .join(',');

    // generate id
    let id = v4();

    // insert product
    await querySQL('call ADMIN_INSERT_PRODUCT(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', [
      id, // id new product
      name, // name product
      loai2, // id loai2 product
      describePro, // describe product
      brand, // id brand product
      material, // id material product
      price, // price product
      promotion, // promotion product
      status, // status product
      imagePathJoin, // img path join product
    ]);

    // insert type product
    if (Array.isArray(colors)) {
      // has many type
      for (let i in colors) {
        await querySQL('call ADMIN_INSERT_TYPE_PRODUCT(?, ?, ?, ?)', [
          id, // id of new product
          colors[i], // color
          sizes[i], // size
          amounts[i], // amount
        ]);
      }
    } else {
      // only 1 type
      await querySQL('call ADMIN_INSERT_TYPE_PRODUCT(?, ?, ?, ?)', [
        id, // id of new product
        colors, // color
        sizes, // size
        amounts, // amount
      ]);
    }

    // send status OK
    res.sendStatus(200);
  } catch (err) {
    res.sendStatus(400);
  }
};

// get edit product
module.exports.getEditProduct = async (req, res, next) => {
  try {
    // get id product
    let { idPro } = req.params;

    // get info of product want to edit
    let data = await querySQL('call ADMIN_SELECT_INFO_PRODUCT(?)', [idPro]);

    // create product obj
    let product = {
      id: idPro,
      name: data[0][0].ten_sanpham,
      describe: data[0][0].mota,
      brand: data[0][0].ma_thuonghieu,
      material: data[0][0].ma_chatlieu,
      price: data[0][0].giaban,
      promotion: data[0][0].khuyenmai,
      loai0: data[0][0].ma_loai0,
      loai1: data[0][0].ma_loai1,
      loai2: data[0][0].ma_loai2,
      imgs: data[0][0].hinhanh.split(','),
      types: [],
    };
    data[1].forEach((item) => {
      let type = {
        color: item.mausac,
        size: item.size,
        amount: item.soluongton,
      };
      product.types.push(type);
    });

    // get brands and matreials form db
    let dataBM = await querySQL('call ADMIN_SELECT_BRAND_MATERIAL()');
    let brands = dataBM[0];
    let materials = dataBM[1];

    // render
    res.render('admin/editproduct', {
      titleSite: 'ShopOH',
      active: 'addpro',
      brands,
      materials,
      product,
    });
  } catch (err) {
    next(err);
  }
};

// put (edit) product
module.exports.putEditProduct = async (req, res, next) => {
  try {
    // get data form req.body
    let { idPro } = req.params;
    let name = req.body.nameProduct;
    let loai2 = +req.body.loai2;
    let describePro = req.body.describePro;
    let brand = +req.body.brand;
    let material = +req.body.material;
    let price = +req.body.price;
    let promotion = +req.body.promotion;
    let colors = req.body.color;
    let sizes = req.body.size;
    let amounts = req.body.amount;
    let status = req.body.status;

    // update product
    await querySQL('call ADMIN_UPDATE_PRODUCT(?, ?, ?, ?, ?, ?, ?, ?, ?)', [
      idPro, // id product
      name, // name product
      loai2, // id loai2 product
      describePro, // describe product
      brand, // id brand product
      material, // id material product
      price, // price product
      promotion, // promotion product
      status, // status product
    ]);

    // delete old types product
    await querySQL('call ADMIN_DELETE_TYPE_PRODUCT(?)', [idPro]);

    // update type product
    if (Array.isArray(colors)) {
      // has many type
      for (let i in colors) {
        await querySQL('call ADMIN_UPDATE_TYPE_PRODUCT(?, ?, ?, ?)', [
          idPro, // id product
          colors[i], // color
          sizes[i], // size
          amounts[i], // amount
        ]);
      }
    } else {
      // only 1 type
      await querySQL('call ADMIN_UPDATE_TYPE_PRODUCT(?, ?, ?, ?)', [
        idPro, // id product
        colors, // color
        sizes, // size
        amounts, // amount
      ]);
    }

    // set flash mgs and redirect
    req.flash('success_mgs', 'Cập nhật sản phẩm thành công');
    res.redirect('/admin/product');
  } catch (err) {
    next(err);
  }
};

// get order list
module.exports.getOrders = async (req, res, next) => {
  try {
    // get status order query
    let status = +req.query.status || 0;
    let idOrder = req.query.idorder || '';

    // set order active tab
    let orderActive = '';
    switch (status) {
      case 0:
        orderActive = 'all';
        break;
      case 1:
        orderActive = 'chuaxacnhan';
        break;
      case 2:
        orderActive = 'daxacnhan';
        break;
      case 3:
        orderActive = 'danggiao';
        break;
      case 4:
        orderActive = 'dagiao';
        break;
      case 5:
        orderActive = 'dahuy';
        break;
      case 6:
        orderActive = 'trahang';
        break;
    }

    // get order list or by id
    let data = await querySQL('call ADMIN_SELECT_ORDER(?, ?)', [
      status,
      idOrder,
    ]);
    // create orders from data query
    // pattern
    // orders: [{idOrder: order}, ...]
    // order: {idOrder, ...., [{product},...], sumPrice}
    let orders = data[0].reduce((acc, cur) => {
      if (!(cur.ma_dondathang in acc)) {
        acc[cur.ma_dondathang] = {
          id: cur.ma_dondathang,
          dateOrder: moment(cur.ngay_dathang).format('DD/MM/YYYY'),
          status: cur.ten_trangthai,
          products: [
            {
              img: cur.hinhanh.split(',')[0],
              color: cur.mausac,
              size: cur.size,
              amount: cur.soluong,
            },
          ],
          sumPrice:
            cur.phi_vanchuyen +
            Math.round(cur.soluong * cur.giaban * (1 - cur.khuyenmai / 100)),
        };
      } else {
        acc[cur.ma_dondathang].products.push({
          img: cur.hinhanh.split(',')[0],
          color: cur.mausac,
          size: cur.size,
          amount: cur.soluong,
        });
        acc[cur.ma_dondathang].sumPrice += Math.round(
          cur.soluong * cur.giaban * (1 - cur.khuyenmai / 100)
        );
      }
      return acc;
    }, {});

    res.render('admin/order', {
      titleSite: 'ShopOH',
      active: 'order',
      orders: Object.values(orders), // only get value orders
      status, // stauts of order
      orderActive, // order active tab
      idOrder, // id order if search
      dateMin: moment().subtract(1, 'months').format('YYYY-MM-DD'), // date min export order
      dateMax: moment().format('YYYY-MM-DD'), // date max export order
    });
  } catch (err) {
    next(err);
  }
};

// get info a order
module.exports.getOrder = async (req, res, next) => {
  try {
    // get id order
    let { idOrder } = req.params;

    // get data order
    let dataOrder = await querySQL('call ADMIN_SELECT_INFO_ORDER(?)', [
      idOrder,
    ]);

    // craete order from data query
    // pattern: order: {id, ...., addr:{....}, data: [dates of order], products: [{product}], sumpPrice}
    let order = {};
    if (dataOrder[0][0]) {
      // re-structor order info
      order.id = dataOrder[0][0].ma_dondathang;
      order.user = dataOrder[0][0].ma_khachhang;
      order.statusId = dataOrder[0][0].ma_trangthai;
      order.status = dataOrder[0][0].ten_trangthai;
      order.addr = {
        name: dataOrder[0][0].ten_nguoinhan,
        phone: dataOrder[0][0].dienthoai_nguoinhan,
        tinh: dataOrder[0][0].tinh,
        huyen: dataOrder[0][0].huyen,
        xa: dataOrder[0][0].xa,
        nha: dataOrder[0][0].nha,
      };
      order.shipFee = dataOrder[0][0].phi_vanchuyen;
      order.date = [];
      if (dataOrder[0][0].ngay_dathang) {
        order.date.unshift({
          time: moment(dataOrder[0][0].ngay_dathang).format(
            'DD/MM/YYYY hh:mm:ss A'
          ),
          st: 'Đặt đơn hàng',
        });
      }
      if (dataOrder[0][0].ngay_xacnhan) {
        order.date.unshift({
          time: moment(dataOrder[0][0].ngay_xacnhan).format(
            'DD/MM/YYYY hh:mm:ss A'
          ),
          st: 'Đã xác nhận đơn hàng',
        });
      }
      if (dataOrder[0][0].ngay_giaohang) {
        order.date.unshift({
          time: moment(dataOrder[0][0].ngay_giaohang).format(
            'DD/MM/YYYY hh:mm:ss A'
          ),
          st: 'Bắt đầu giao đơn hàng',
        });
      }
      if (dataOrder[0][0].ngay_nhanhang) {
        order.date.unshift({
          time: moment(dataOrder[0][0].ngay_nhanhang).format(
            'DD/MM/YYYY hh:mm:ss A'
          ),
          st: 'Giao đơn hàng',
        });
      }
      if (dataOrder[0][0].ngay_huyhang) {
        order.date.unshift({
          time: moment(dataOrder[0][0].ngay_huyhang).format(
            'DD/MM/YYYY hh:mm:ss A'
          ),
          st: 'Hủy đơn hàng',
        });
      }
      order.products = [];
      order.sumPrice = 0;
    }
    for (let pro of dataOrder[1]) {
      let product = {
        name: pro.ten_sanpham,
        img: pro.hinhanh.split(',')[0],
        color: pro.mausac,
        size: pro.size,
        amount: pro.soluong,
        price: pro.giaban,
        promotion: pro.khuyenmai,
      };
      order.sumPrice += Math.round(
        product.amount * (product.price * (1 - product.promotion / 100))
      );
      order.products.push(product);
    }

    // get status of order can has
    let dataStatus = await querySQL('call ADMIN_SELECT_CAN_STATUS_ORDER(?)', [
      order.statusId,
    ]);

    // render
    res.render('admin/orderinfo', {
      titleSite: 'shopOH',
      order, // order
      statusCan: dataStatus[0], // status can has
      successMgs: req.flash('success_mgs'),
    });
  } catch (err) {
    next(err);
  }
};

// put status order
module.exports.putStatusOrder = async (req, res, next) => {
  try {
    // get order id
    let { idOrder } = req.params;

    // get status update
    let status = +req.body.status;

    // update status order
    await querySQL('call ADMIN_UPDATE_STATUS_ORDER(?, ?)', [idOrder, status]);

    // add notification update status order for customer
    let statusOrderText = [
      'Đã xác nhận',
      'Đang giao',
      'Đã giao',
      'Đã huỷ',
      'Trả hàng/Hoàn tiền',
    ];
    let id = v4();
    let subject = 'Cập nhật đơn hàng';
    let body = `Đơn hàng ${idOrder} của bạn đã được cập nhật trạng thái: ${
      statusOrderText[status - 2]
    }`;
    let img = '/images/shop/noorder.png';

    await querySQL(
      'call ADMIN_INSERT_NOTIFICATION_UPDATE_ORDER(?, ?, ?, ?, ?)',
      [id, subject, body, img, idOrder]
    );

    req.flash('success_mgs', 'Cập nhật trạng thái đơn hàng thành công');
    res.redirect(`/admin/order/${idOrder}`);
  } catch (err) {
    next(err);
  }
};

// delete order
module.exports.deleteOrder = async (req, res, next) => {
  try {
    // gte id order
    let { idOrder } = req.params;

    // delete order
    await querySQL('call ADMIN_DELETE_ORDER(?)', [idOrder]);

    res.sendStatus(200);
  } catch (err) {
    res.sendStatus(400);
  }
};

// gte notificaton list
module.exports.getNotification = async (req, res, next) => {
  try {
    // get string qery
    let searchNoti = req.query.searchNoti || '';
    // let searchNotification = `'%${searchNoti}%'`;

    // get data notificatin
    let data = await querySQL('call ADMIN_SELECT_NOTIFICATION()');
    notifications = data[0];

    res.render('admin/notification', {
      titleSite: 'ShopOH',
      active: 'notification',
      notifications: data[0],
      searchNoti,
    });
  } catch (err) {
    next(err);
  }
};

// get add notification
module.exports.getAddNotification = (req, res, next) => {
  try {
    res.render('admin/addnotification', {
      titleSite: 'ShopOH',
      active: 'addnoti',
    });
  } catch (err) {
    next(err);
  }
};

// post a new notification
module.exports.postAddNotification = async (req, res) => {
  try {
    // get data form req.body
    let subject = req.body.subjectNoti;
    let body = req.body.contentNoti;
    let status = +req.body.status;
    let public = status === 1 ? true : false;
    // create path for imgage upload
    let imagePath = `/images/shop/${req.file.filename}`;

    // generate id
    let id = v4();

    // insert product
    await querySQL('call ADMIN_INSERT_NOTIFICATION(?, ?, ?, ?, ?)', [
      id, // id new notification
      subject, // subject notification
      body, // body notification
      imagePath, // image path
      public, // public or hide (true or false)
    ]);

    // send status OK
    res.sendStatus(200);
  } catch (err) {
    res.sendStatus(400);
  }
};

// delete notification
module.exports.deleteNotification = async (req, res) => {
  try {
    // get id notification want delete
    let { idNoti } = req.params;

    // delete and get img of notification
    let dataImg = await querySQL('call ADMIN_DELETE_NOTIFICATION(?)', [idNoti]);

    // delete img notification
    // remove img
    let img = dataImg[0][0].hinhanh;
    fs.unlink(path.join(__dirname, '..', 'public', img), (errUnlink) => {
      if (errUnlink) {
        throw errUnlink;
      }
    });
    res.sendStatus(200);
  } catch (err) {
    res.sendStatus(400);
  }
};

// get edit notification
module.exports.getEditNotification = async (req, res, next) => {
  try {
    // get id notification want update
    let { idNoti } = req.params;

    // get notification info
    let data = await querySQL('call ADMIN_SELECT_NOTIFICATION_INFO(?)', [
      idNoti,
    ]);
    let notification = data[0][0];

    // render
    res.render('admin/editnotification', {
      titleSite: 'ShopOH',
      active: 'addnoti',
      notification,
    });
  } catch (err) {
    next(err);
  }
};

// put notification
module.exports.putEditNotification = async (req, res, next) => {
  try {
    // get data form req.body
    let subject = req.body.subjectNoti;
    let body = req.body.contentNoti;
    let status = +req.body.status;
    // get id notification want update
    let { idNoti } = req.params;
    let public = status === 1 ? true : false;
    // insert product
    await querySQL('call ADMIN_UPDATE_NOTIFICATION(?, ?, ?, ?)', [
      idNoti, // id new notification
      subject, // subject notification
      body, // body notification
      public, // public?
    ]);

    res.redirect('/admin/notification');
  } catch (err) {
    next(err);
  }
};

module.exports.exportsOrders = async (req, res, next) => {
  try {
    // get date range and status want to exports
    let { dateMin, dateMax } = req.query;
    let status = +req.query.status || 0;

    // get orders belong date range and status
    let dataOrder = await querySQL('call ADMIN_EXPORTS_ORDERS(?, ?, ?)', [
      dateMin,
      dateMax,
      status,
    ]);

    // create orders
    let orders = dataOrder[0].reduce((acc, cur) => {
      if (!(cur.ma_dondathang in acc)) {
        acc[cur.ma_dondathang] = {
          'Mã đơn hàng': cur.ma_dondathang,
          'Ngày đặt hàng': cur.ngay_dathang,
          'Trạng thái đơn hàng': cur.ten_trangthai,
          'Phương thức giao hàng': 'Giao hàng nhanh',
          'Ngày giao hàng': cur.ngay_giaohang,
          'Thời gian giao hàng':
            moment(cur.ngay_nhanhang).diff(cur.ngay_giaohang, 'days') || null,
          'Tên sản phẩm': `[${cur.ten_sanpham}]`,
          'Phân loại hàng': `[${cur.mausac}-${cur.size}]`,
          'Giá gốc': `[${cur.giaban}]`,
          'Khuyến mãi': `[${cur.khuyenmai}]`,
          'Số lượng': `[${cur.soluong}]`,
          'Tiền đơn hàng': Math.round(
            cur.giaban * cur.soluong * (1 - cur.khuyenmai / 100)
          ),
          'Phí vận chuyển': cur.phi_vanchuyen,
          'Tổng số tiền':
            Math.round(cur.giaban * cur.soluong * (1 - cur.khuyenmai / 100)) +
            cur.phi_vanchuyen,
          'Phương thức thanh toán': 'Thanh toán khi nhận hàng',
          'Thời gian hoàn thành đơn hàng':
            moment(cur.ngay_nhanhang).diff(cur.ngay_dathang, 'days') || null,
          'Username (Buyer)': cur.taikhoan,
          'Tên người nhận': cur.ten_nguoinhan,
          'Số điện thoại': cur.dienthoai_nguoinhan,
          'Tỉnh/Thành phố': cur.tinh,
          'Quận/Thị trấn/Huyện': cur.huyen,
          'Phường/Xã': cur.xa,
          'Địa chỉ nhận hàng': `${cur.ten_nguoinhan} (${cur.dienthoai_nguoinhan}), ${cur.nha}, ${cur.xa}, ${cur.huyen}, ${cur.tinh}`,
        };
      } else {
        acc[cur.ma_dondathang]['Tên sản phẩm'] += ` + [${cur.ten_sanpham}]`;
        acc[cur.ma_dondathang][
          'Phân loại hàng'
        ] += ` + [${cur.mausac}-${cur.size}]`;
        acc[cur.ma_dondathang]['Giá gốc'] += ` + [${cur.giaban}]`;
        acc[cur.ma_dondathang]['Khuyến mãi'] += ` + [${cur.khuyenmai}]`;
        acc[cur.ma_dondathang]['Số lượng'] += ` + [${cur.soluong}]`;
        acc[cur.ma_dondathang]['Tiền đơn hàng'] += Math.round(
          cur.giaban * cur.soluong * (1 - cur.khuyenmai / 100)
        );
        acc[cur.ma_dondathang]['Tổng số tiền'] += Math.round(
          cur.giaban * cur.soluong * (1 - cur.khuyenmai / 100)
        );
      }
      return acc;
    }, {});

    let newWb = xlsx.utils.book_new();
    let newWs = xlsx.utils.json_to_sheet(Object.values(orders), {
      cellDates: true,
      header: [
        'Mã đơn hàng',
        'Ngày đặt hàng',
        'Trạng thái đơn hàng',
        'Phương thức giao hàng',
        'Ngày giao hàng',
        'Thời gian giao hàng',
        'Tên sản phẩm',
        'Phân loại hàng',
        'Giá gốc',
        'Khuyến mãi',
        'Số lượng',
        'Tiền đơn hàng',
        'Phí vận chuyển',
        'Tổng số tiền',
        'Phương thức thanh toán',
        'Thời gian hoàn thành đơn hàng',
        'Username (Buyer)',
        'Tên người nhận',
        'Số điện thoại',
        'Tỉnh/Thành phố',
        'Quận/Thị trấn/Huyện',
        'Phường/Xã',
        'Địa chỉ nhận hàng',
      ],
    });
    let colsWs = [
      { wch: 50 }, // id
      { wch: 15 }, // ngay dat hang
      { wch: 25 }, // trang thai don hang
      { wch: 25 }, // phuong thuc giao hang
      { wch: 15 }, // Ngày giao hàng
      { wch: 20 }, // Thời gian giao hàng
      { wch: 100 }, // Tên sản phẩm
      { wch: 80 }, // Phân loại hàng
      { wch: 40 }, // Giá gốc
      { wch: 30 }, // Khuyến mãi
      { wch: 30 }, // Số lượng
      { wch: 15 }, // Tiền đơn hàng
      { wch: 15 }, // Phí vận chuyển
      { wch: 15 }, // Tổng số tiền
      { wch: 25 }, // Phương thức thanh toán
      { wch: 30 }, // Thời gian hoàn thành đơn hàng
      { wch: 20 }, // Username (Buyer)
      { wch: 30 }, // Tên người nhận
      { wch: 15 }, // Số điện thoại
      { wch: 15 }, // Tỉnh/Thành phố
      { wch: 15 }, // TP/Quận/Huyện
      { wch: 15 }, // Phường/Xã
      { wch: 100 }, // Địa chỉ nhận hàng
    ];
    newWs['!cols'] = colsWs;
    xlsx.utils.book_append_sheet(newWb, newWs, 'Order');
    let textName = [
      'all',
      'unpaid',
      'confirmed',
      'shipping',
      'completed',
      'cancelled',
      'return',
    ];

    let filename = `order.${textName[status]}.${dateMin.replace(
      /-/g,
      ''
    )}_${dateMax.replace(/-/g, '')}.xlsx`;
    let pathFile = path.join(__dirname, '..', filename);
    xlsx.writeFile(newWb, pathFile);

    res.download(pathFile, filename, (err) => {
      if (err) {
        throw err;
      }
      fs.unlink(pathFile, (err) => {
        if (err) {
          throw err;
        }
      });
    });
  } catch (err) {
    next(err);
  }
};
