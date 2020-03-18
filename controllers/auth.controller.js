const bcrypt = require('bcrypt');
const Joi = require('@hapi/joi'); // validate body form
const uuid = require('uuid');

// query SQL function
const querySQL = require('../configure/querySQL');

// get login
module.exports.getLogin = (req, res) => {
  // get referer url go to after login successful
  let referer = req.headers.referer || '/';
  if (/register$/.test(referer)) {
    referer = '/';
  }

  res.render('account/login', {
    titleSite: 'ShopOH - Login',
    referer, // referer url
    csrfToken: req.csrfToken(), // csrfToken (match csrfToken => allow form)
    successMgs: req.flash('success_mgs')
  });
};

// get register
module.exports.getRegister = (req, res) => {
  res.render('account/register', {
    titleSite: 'ShopOH - Register',
    csrfToken: req.csrfToken() // csrfToken (match csrfToken => allow form)
  });
};

// logout
module.exports.getLogout = (req, res) => {
  // remove cookie uuid (id user)
  res.clearCookie('uuid');

  res.redirect('/');
};

// post login
module.exports.postLogin = async (req, res, next) => {
  // get data login
  let { account, password, referer } = req.body;

  // validation data
  // create schema obj validate
  const schema = Joi.object({
    account: Joi.string()
      .pattern(/^\w{6,24}$/)
      .required(),
    password: Joi.string()
      .min(4)
      .required()
  });
  // validate => get error
  let { error } = schema.validate({ account, password });

  // error => display view
  let errorText = null;

  // user
  let user = null;

  // validate error
  if (error) {
    errorText = 'Thông tin đăng nhập không đúng';
  } else {
    // pass validate

    // check account exists
    let checkAccount = await querySQL('call CHECK_ACCOUNT(?)', [account]);

    // get user
    user = checkAccount[0][0];

    if (!user) {
      // not exists user in db
      errorText = 'Thông tin đăng nhập không đúng';
    } else {
      // exists user in db
      // check password correct
      let checkPass = await bcrypt.compare(password, user.matkhau);
      if (!checkPass) {
        // incorrect password
        errorText = 'Thông tin đăng nhập không đúng';
      }
    }
  }

  // check exists error
  if (errorText) {
    // has error
    res.render('account/login', {
      titleSite: 'ShopOH - Login',
      referer,
      csrfToken: req.csrfToken(),
      errorText,
      account // account => display view
    });
  } else {
    // no error
    // login successful => rederect page current
    // set cookie uuid (id user)
    res.cookie('uuid', user.ma_khachhang, { signed: true });

    // remove cookie _csrf
    res.clearCookie('_csrf');

    // redirect referer url
    res.redirect(referer);
  }
};

// post register
module.exports.postRegister = async (req, res, next) => {
  // get data register
  let { account, password, password2 } = req.body;

  // validation data
  // create chema obj
  const schema = Joi.object({
    account: Joi.string()
      .pattern(/^\w{6,24}$/)
      .required(),
    password: Joi.string()
      .min(6)
      .required(),
    password2: Joi.ref('password')
  });
  // validate
  // get error validate
  let { error } = schema.validate({ account, password, password2 });

  let errorTexts = [];

  // error validate
  if (error) {
    // return res.status(400).json({ error: 'Thông tin đăng nhập không đúng' });
    if (error.details[0].path[0] === 'account') {
      errorTexts.push(
        'Chiều dài tên tài khoản từ 6 đến 24 kí tự, không chứa các kí tự đặt biệt'
      );
    } else if (error.details[0].path[0] === 'password') {
      errorTexts.push('Mật khẩu ngắn nhất 6 kí tự');
    } else if (error.details[0].path[0] === 'password2') {
      errorTexts.push('Mật khẩu nhập lại không đúng');
    }
  } else {
    // check account exists in db
    let checkAccount = await querySQL('call CHECK_ACCOUNT(?)', [account]);

    // get user
    let user = checkAccount[0][0];

    // exists user in db
    if (user) {
      errorTexts.push('Tên tài khoản đã bị đăng kí');
    }
  }

  // has error
  if (errorTexts.length > 0) {
    res.render('account/register', {
      titleSite: 'ShopOH - Register',
      csrfToken: req.csrfToken(),
      errorTexts,
      account // account => display view
    });
  } else {
    // pass => insert db
    // generate idUser
    let idUser = uuid.v4();

    // hash password
    let salt = await bcrypt.genSalt(10);
    let hash = await bcrypt.hash(password, salt);

    // insert db
    await querySQL('call ADD_USER(?, ?, ?)', [idUser, account, hash]);

    // remove cookie _csrf
    res.clearCookie('_csrf');

    // set flash register successful
    req.flash('success_mgs', 'Đăng kí tài khoản thành công, có thể đăng nhập');

    // redirect login endpoint
    res.redirect('/login');
  }
};
