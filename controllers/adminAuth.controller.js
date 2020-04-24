const bcrypt = require('bcrypt');

module.exports.getAuth = (req, res, next) => {
  try {
    res.render('admin/auth', {
      titleSite: 'ShopOH',
      csrfToken: req.csrfToken(),
      errMgs: req.flash('error_mgs'),
    });
  } catch (err) {
    next(err);
  }
};

module.exports.postAuth = async (req, res, next) => {
  try {
    // get admin code1, code2
    let { code1, code2 } = req.body;

    // check code1, code2
    let check1 = await bcrypt.compare(code1, process.env.ADMIN_CODE1);
    let check2 = await bcrypt.compare(code2, process.env.ADMIN_CODE2);
    if (check1 && check2) {
      // check correct
      res.cookie('aid', process.env.ADMIN_ID, { signed: true, sameSite: true });
      res.redirect('/admin');
    } else {
      // check incorrect
      req.flash('error_mgs', 'Mã xác minh không hợp lệ');
      res.redirect('/adminAuth');
    }
  } catch (err) {
    next(err);
  }
};

module.exports.logout = (req, res) => {
  try {
    res.clearCookie('aid');
    res.redirect('/');
  } catch (err) {
    next(err);
  }
};
