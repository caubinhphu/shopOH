const querySQL = require('../configure/querySQL');

module.exports = async (req, res, next) => {
  try {
    let idUser = req.signedCookies.uuid;
    if (!idUser) {
      return res.redirect('/login');
    }

    let data = await querySQL('call CHECK_ACCOUNT_ID(?)', [idUser]);

    let user = data[0][0];

    if (!user) {
      return res.redirect('/login');
    }

    next();
  } catch (error) {
    next(error);
  }
};
