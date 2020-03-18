const bcrypt = require('bcrypt');
const Joi = require('@hapi/joi'); // validate body form
const uuid = require('uuid');

// query SQL function
const querySQL = require('../configure/querySQL');

module.exports.getLogin = (req, res) => {
  let referer = req.headers.referer || '/';
  res.render('account/login', {
    titleSite: 'ShopOH - Login',
    referer,
    csrfToken: req.csrfToken()
  });
};

module.exports.getRegister = (req, res) => {
  res.render('account/register', {
    titleSite: 'ShopOH - Register',
    csrfToken: req.csrfToken()
  });
};

module.exports.getLogout = (req, res) => {
  res.clearCookie('uuid');
  res.redirect('/');
};

module.exports.postLogin = async (req, res, next) => {
  // get data login
  let { account, password, referer } = req.body;

  // validation
  const schema = Joi.object({
    account: Joi.string()
      .pattern(/^\w{6,24}$/)
      .required(),
    password: Joi.string()
      .min(4)
      .required()
  });

  let errorText = null;

  let { error } = schema.validate({ account, password });

  let user = null;

  if (error) {
    // return res.status(400).json({ error: 'Thông tin đăng nhập không đúng' });
    errorText = 'Thông tin đăng nhập không đúng';
  } else {
    // check account exists
    let checkAccount = await querySQL('call CHECK_ACCOUNT(?)', [account]);

    user = checkAccount[0][0];

    if (!user) {
      // return res.status(400).json({ error: 'Tài khoản không tồn tại' });
      errorText = 'Thông tin đăng nhập không đúng';
    } else {
      // check password correct
      let checkPass = await bcrypt.compare(password, user.matkhau);
      if (!checkPass) {
        // return res.status(400).json({ error: 'Mật khẩu không đúng' });
        errorText = 'Thông tin đăng nhập không đúng';
      }
    }
  }
  if (errorText) {
    res.render('account/login', {
      titleSite: 'ShopOH - Login',
      referer,
      csrfToken: req.csrfToken(),
      errorText,
      account
    });
  } else {
    // login successful => rederect page current
    res.cookie('uuid', user.ma_khachhang, { signed: true });

    res.clearCookie('_csrf');

    res.redirect(referer);
  }
};

module.exports.postRegister = async (req, res, next) => {
  // get data login
  let { account, password, password2 } = req.body;

  // validation
  const schema = Joi.object({
    account: Joi.string()
      .pattern(/^\w{6,24}$/)
      .required(),
    password: Joi.string()
      .min(6)
      .required(),
    password2: Joi.ref('password')
  });

  let { error } = schema.validate({ account, password, password2 });
  let errorTexts = [];
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
    let checkAccount = await querySQL('call CHECK_ACCOUNT(?)', [account]);
    let user = checkAccount[0][0];
    if (user) {
      errorTexts.push('Tên tài khoản đã bị đăng kí');
    }
  }

  if (errorTexts.length > 0) {
    res.render('account/register', {
      titleSite: 'ShopOH - Register',
      csrfToken: req.csrfToken(),
      errorTexts,
      account
    });
  } else {
    // generate idUser
    let idUser = uuid.v4();

    // hash password
    let salt = await bcrypt.genSalt(10);
    let hash = await bcrypt.hash(password, salt);
    // console.log(hash);

    await querySQL('call ADD_USER(?, ?, ?)', [idUser, account, hash]);

    res.clearCookie('_csrf');

    res.redirect('/login');
  }
};
