const querySQL = require('../configure/querySQL');

module.exports = async (req, res, next) => {
  try {
    let { style } = req.params,
      type = 0;
    if (style === 'thoitrangnam') {
      type = 1;
    } else if (style === 'thoitrangnu') {
      type = 2;
    }

    let filterList = await querySQL('call SP_SELECT_FILTER_LIST(?)', [type]);

    res.locals.filterType = filterList[0];
    res.locals.filterMaterial = filterList[1];

    next();
  } catch (error) {
    next(error);
  }
};
