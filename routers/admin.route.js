const express = require('express');
const csurf = require('csurf');
const multer = require('multer');
const path = require('path');
const controller = require('../controllers/admin.controller');

const storage = multer.diskStorage({
  destination: './public/images/products/',
  filename: (req, file, cb) => {
    let uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);
    cb(
      null,
      file.fieldname + '-' + uniqueSuffix + path.extname(file.originalname)
    );
  },
});

// upload file
const upload = multer({
  storage: storage,
}).array('image');

const storageNotification = multer.diskStorage({
  destination: './public/images/shop/',
  filename: (req, file, cb) => {
    let uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);
    cb(null, 'notification-' + uniqueSuffix + path.extname(file.originalname));
  },
});

// upload file
const uploadNotification = multer({
  storage: storageNotification,
}).single('image');

const router = express.Router();

const csrfProtection = csurf({ cookie: true, signed: true });

router.get('/', controller.getHome);

router.get('/product', controller.getProduct);

router.get('/order', controller.getOrders);

router.get('/exports/order', controller.exportsOrders);

router.get('/danhmuc', controller.getDanhMuc);

router.get('/product/add', controller.getAddProduct);

router.get('/notification', controller.getNotification);

router.get('/notification/add', controller.getAddNotification);

router.post(
  '/notification/add',
  uploadNotification,
  controller.postAddNotification
);

router.get('/notification/edit/:idNoti', controller.getEditNotification);

router.put('/notification/edit/:idNoti', controller.putEditNotification);

router.delete('/notification/:idNoti', controller.deleteNotification);

router.get('/product/edit/:idPro', controller.getEditProduct);

router.post('/product/add', upload, controller.postAddProduct);

router.put('/product/edit/:idPro', controller.putEditProduct);

router.delete('/product/:idPro', controller.deleteProduct);

router.get('/order/:idOrder', controller.getOrder);

router.put('/order/:idOrder', controller.putStatusOrder);

router.delete('/order/:idOrder', controller.deleteOrder);

module.exports = router;
