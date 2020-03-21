const fs = require('fs');
const multer = require('multer');
const path = require('path');
const querySQL = require('../configure/querySQL');

const { profileValidate } = require('../validates/account.validate');

const storage = multer.diskStorage({
  destination: './public/images/users/',
  filename: (req, file, cb) => {
    let uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);
    cb(
      null,
      file.fieldname + '-' + uniqueSuffix + path.extname(file.originalname)
    );
  }
});

// upload file
const upload = multer({
  storage: storage,
  // limits: { fileSize: 10 },
  fileFilter: (req, file, cb) => {
    // ext type
    const extTypes = /jpeg|jpg|png|gif/;

    // check extname
    const extname = extTypes.test(
      path.extname(file.originalname).toLowerCase()
    );

    // check mimetype
    const mime = extTypes.test(file.mimetype);

    if (extname && mime) {
      cb(null, true);
    } else {
      cb('File ảnh không đúng định dạng');
    }
  }
}).single('avatar');

// get profile
module.exports.getProfile = async (req, res, next) => {
  try {
    // get account user current
    let data = await querySQL('call CHECK_ACCOUNT_ID(?)', [req.userId]);
    let account = data[0][0];

    // convert account birthdate => string type yyyy-mm-dd
    // function format date type yyyy-mm-dd
    const formatDate = date => {
      let d = new Date(date),
        year = d.getFullYear(),
        month = d.getMonth() + 1,
        day = d.getDate();

      if (day < 10) {
        day = '0' + day;
      }
      if (month < 10) {
        month = '0' + month;
      }
      return [year, month, day].join('-');
    };
    if (account.ngaysinh) {
      account.ngaysinh = formatDate(account.ngaysinh);
    }

    // render
    res.render('customer/personal-profile', {
      titleSite: 'ShopOH - Tài khoản của tôi',
      active: 'profile', // tab active
      account, // account user
      csrfToken: req.csrfToken(), // csrf token
      errorMgs: req.flash('error_mgs'), // error mgs flash
      successMgs: req.flash('success_mgs') // success mgs flash
    });
  } catch (error) {
    next(error);
  }
};

// get purchase
module.exports.getPurchase = (req, res, next) => {
  res.render('customer/personal-profile', {
    titleSite: 'ShopOH - Tài khoản của tôi',
    active: 'purchase'
  });
};

// get profile password
module.exports.getProfilePassword = (req, res, next) => {
  res.render('customer/personal-profile', {
    titleSite: 'ShopOH - Tài khoản của tôi',
    active: 'password'
  });
};

// get notification
module.exports.getNotification = (req, res, next) => {
  res.render('customer/personal-notification', {
    titleSite: 'ShopOH - Tài khoản của tôi',
    active: 'notification'
  });
};

// get address
module.exports.getAddress = (req, res, next) => {
  res.render('customer/personal-address', {
    titleSite: 'ShopOH - Tài khoản của tôi',
    active: 'address'
  });
};

// edit profile
module.exports.postProfile = async (req, res, next) => {
  try {
    // get data form
    let { username, gender, birthday, phone } = req.body;

    // validate
    let { error } = profileValidate({ username, gender, birthday, phone });
    let errorTexts = [];

    // error validate
    if (error) {
      if (error.details[0].path[0] === 'username') {
        errorTexts.push(
          'Tên không hợp lệ (dài tối đa 100 kí tự, không chứa các kí tự đặt biệt)'
        );
      } else if (error.details[0].path[0] === 'gender') {
        errorTexts.push('Giới tính không hợp lệ');
      } else if (error.details[0].path[0] === 'birthday') {
        errorTexts.push('Ngày sinh không hợp lệ');
      } else if (error.details[0].path[0] === 'phone') {
        errorTexts.push('Số điện thoại không hợp lệ');
      }
    }

    // has error validate
    if (errorTexts.length > 0) {
      req.flash('error_mgs', errorTexts);
      return res.redirect('/account/profile');
    }

    // pass validate
    // update db
    await querySQL('call UPDATE_PROFILE(?, ?, ?, ?, ?)', [
      req.userId,
      username,
      gender,
      birthday,
      phone
    ]);

    req.flash('success_mgs', 'Cập nhật thông tin thành công');
    res.redirect('/account/profile');
  } catch (err) {
    next(err);
  }
};

module.exports.putAvatar = async (req, res) => {
  upload(req, res, async err => {
    if (err) {
      return res.status(400).json({ mgs: err.message });
    } else {
      let urlAvatar = `/images/users/${req.file.filename}`;
      try {
        let data = await querySQL('call UPDATE_AVATAR(?, ?)', [
          req.userId,
          urlAvatar
        ]);
        // path old avatar
        let oldAvatar = data[0][0].avatar;

        // remove old avatar
        if (oldAvatar !== '/images/users/default-avatar.jpg') {
          fs.unlink(
            path.join(__dirname, '..', 'public', oldAvatar),
            errUnlink => {
              if (errUnlink) {
                throw errUnlink;
              }
            }
          );
        }
      } catch (error) {
        return res.status(400).json({ mgs: error.message });
      }
      return res
        .status(200)
        .json({ mgs: 'Cập nhật avatar thành công', src: urlAvatar });
    }
  });
};
