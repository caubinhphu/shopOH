const querySQL = require('../configure/querySQL');

module.exports = async (req, res, next) => {
  try {
    let idUser = req.signedCookies.uuid;
    if (!idUser) {
      res.redirect('/login');
    }

    let data = await querySQL('call CHECK_ACCOUNT_ID(?)', [idUser]);

    let user = data[0][0];

    if (!user) {
      res.redirect('/login');
    }

    res.locals.user = user.taikhoan;

    next();
  } catch (error) {
    next(error);
  }
};
