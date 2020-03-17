const bcrypt = require('bcrypt');
const Joi = require('@hapi/joi'); // validate body form

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
    titleSite: 'ShopOH - Register'
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

  let { error, value } = schema.validate({ account, password });

  if (error) {
    return res.status(400).json({ error: 'Thông tin đăng nhập không đúng' });
  }

  // check account exists
  let checkAccount = await querySQL('call CHECK_ACCOUNT(?)', [account]);

  let user = checkAccount[0][0];

  if (!user) {
    return res.status(400).json({ error: 'Tài khoản không tồn tại' });
  }

  // check password correct
  let checkPass = await bcrypt.compare(password, user.matkhau);
  if (!checkPass) {
    return res.status(400).json({ error: 'Mật khẩu không đúng' });
  }

  // login successful => rederect page current
  res.cookie('uuid', user.ma_khachhang, { signed: true });

  res.clearCookie('_csrf');

  res.redirect(referer);
};
