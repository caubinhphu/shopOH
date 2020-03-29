// SQL query function
const querySQL = require('../configure/querySQL');

module.exports = async function getNotification(req, res, next) {
  if (req.userId) {
    let data = await querySQL('call SELECT_NOTIFICATION(?)', [req.userId]);
    // set notifications
    res.locals.notifications = data[0];
  }
  next();
};
