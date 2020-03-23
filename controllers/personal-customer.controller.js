const fs = require('fs');
const multer = require('multer');
const path = require('path');
const bcrypt = require('bcrypt');
const querySQL = require('../configure/querySQL');

const {
  profileValidate,
  changePassValidate,
  addressValidate
} = require('../validates/account.validate');

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
  res.render('customer/personal-password', {
    titleSite: 'ShopOH - Tài khoản của tôi',
    active: 'password',
    csrfToken: req.csrfToken(), // csrf token
    errorMgs: req.flash('error_mgs'), // error mgs flash
    successMgs: req.flash('success_mgs') // success mgs flash
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
module.exports.getAddress = async (req, res, next) => {
  // get data address
  let data = await querySQL('call SELECT_ADDRESS(?)', [req.userId]);

  res.render('customer/personal-address', {
    titleSite: 'ShopOH - Tài khoản của tôi',
    active: 'address',
    csrfToken: req.csrfToken(),
    successMgs: req.flash('success_mgs'),
    addresses: data[0]
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

module.exports.postProfilePassword = async (req, res, next) => {
  try {
    // get data from form body
    let {
      oldpassword: oldPassword,
      newpassword: newPassword,
      newpassword2: newPassword2
    } = req.body;

    // validate data
    // get error validate
    let { error } = changePassValidate({
      oldPassword,
      newPassword,
      newPassword2
    });

    // validate error
    let textError = '';
    if (error) {
      if (error.details[0].path[0] === 'oldPassword') {
        textError = 'Mật khẩu cũ không đúng';
      } else if (error.details[0].path[0] === 'newPassword') {
        textError = 'Mật khẩu mới không hợp lệ (ngắn nhất 6 kí tự)';
      } else if (error.details[0].path[0] === 'newPassword2') {
        textError = 'Xác nhận mật khẩu mới không đúng';
      }
      req.flash('error_mgs', textError);
      return res.redirect('/account/password');
    }

    // pass validate
    // check old password
    let data = await querySQL('call CHECK_ACCOUNT_ID(?)', [req.userId]);

    if (data[0][0]) {
      // get old password
      let oldPasswordHash = data[0][0].matkhau;

      // check old password
      let checkPass = await bcrypt.compare(oldPassword, oldPasswordHash);
      if (!checkPass) {
        req.flash('error_mgs', 'Mật khẩu cũ không đúng');
        return res.redirect('/account/password');
      }

      // correct old password
      // change password
      // hass new password
      let salt = await bcrypt.genSalt(10);
      let hash = await bcrypt.hash(newPassword, salt);
      // update db
      await querySQL('call UPDATE_PASSWORD(?, ?)', [req.userId, hash]);

      req.flash('success_mgs', 'Thay đổi mật khẩu thành công');
      return res.redirect('/account/password');
    } else {
      res.redirect('/login');
    }
  } catch (err) {
    next(err);
  }
};

module.exports.getHCVN = (req, res) => {
  res.status(200).sendFile(path.join(__dirname, '..', 'hcvnmini.json'));
};

module.exports.postAddress = async (req, res, next) => {
  try {
    // get data form
    let { name, phone, tinh, huyen, xa, homenum } = req.body;

    // validate
    let { error } = addressValidate({ name, phone, tinh, huyen, xa, homenum });
    // validate error
    let errorText = '';
    if (error) {
      if (error.details[0].path[0] === 'name') {
        errorText =
          'Tên không hợp lệ (dài tối đa 100 kí tự, không chứa các kí tự đặt biệt)';
      } else if (error.details[0].path[0] === 'phone') {
        errorText = 'Số điện thoại không hợp lệ';
      } else if (error.details[0].path[0] === 'tinh') {
        errorText = 'Tỉnh/Thành phố không hợp lệ';
      } else if (error.details[0].path[0] === 'huyen') {
        errorText = 'Quận/Huyện không hợp lệ';
      } else if (error.details[0].path[0] === 'xa') {
        errorText = 'Xã/Phường không hợp lệ';
      } else if (error.details[0].path[0] === 'homenum') {
        errorText = 'Tòa nhà, tên đường không hợp lệ';
      }
      return res.render('customer/personal-address', {
        titleSite: 'ShopOH - Tài khoản của tôi',
        active: 'address',
        csrfToken: req.csrfToken(),
        errorMgs: errorText,
        body: { name, phone, tinh, huyen, xa, homenum },
        showModalAddress: true
      });
    }

    // pass validate
    // insert db
    await querySQL('call ADD_ADDRESS(?, ?, ?, ?, ?, ?, ?)', [
      req.userId,
      name,
      phone,
      tinh,
      huyen,
      xa,
      homenum
    ]);
    req.flash('success_mgs', 'Thêm địa chỉ thành công');
    res.redirect('/account/address');
  } catch (err) {
    next(err);
  }
};
