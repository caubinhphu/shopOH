const querySQL = require('../configure/querySQL');

module.exports = async (req, res, next) => {
  try {
    // get style (male or female)
    let { style } = req.params,
      type = 0;

    if (style === 'thoitrangnam') {
      // male
      type = 1;
    } else if (style === 'thoitrangnu') {
      // female
      type = 2;
    }

    // Being filter by type1?
    let type1 = req.query.filterType1 || -1; // yes || no

    // get filter item
    let filterList = await querySQL('call SP_SELECT_FILTER_LIST(?, ?)', [
      type, // type0 (style)
      +type1 // type1
    ]);

    // set type filter item for view
    if (type1 === -1) {
      // no type1
      res.locals.filterType = filterList[0];
    } else {
      // yes type1
      res.locals.filterType = filterList[2];
    }
    // set material filter item for view
    res.locals.filterMaterial = filterList[1];

    next();
  } catch (error) {
    next(error);
  }
};
