const querySQL = require('../configure/querySQL');

module.exports = async (req, res, next) => {
  let idUser = req.signedCookies.uuid;
  if (idUser) {
    let data = await querySQL('call CHECK_ACCOUNT_ID(?)', [idUser]);

    let user = data[0][0];

    if (user) {
      res.locals.user = user.taikhoan;
      res.locals.avatarUser = user.avatar;
    }
  }
  next();
};
