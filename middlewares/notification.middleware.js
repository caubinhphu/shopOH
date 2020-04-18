const moment = require('moment');
// SQL query function
const querySQL = require('../configure/querySQL');

module.exports = async function getNotification(req, res, next) {
  if (req.userId) {
    let data = await querySQL('call SELECT_NOTIFICATION(?)', [req.userId]);
    // set notifications
    res.locals.notifications = data[0].map((noti) => {
      noti.ngaydang = moment(noti.ngaydang).format('DD/MM/YYYY hh:mm:ss A');
      return noti;
    });
  }
  next();
};
