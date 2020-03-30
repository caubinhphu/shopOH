const querySQL = require('../configure/querySQL');

module.exports.getHome = (req, res, next) => {
  try {
    res.render('admin/index', {
      titleSite: 'ShopOH'
    });
  } catch (err) {
    next(err);
  }
};

module.exports.getProduct = async (req, res, next) => {
  try {
    res.render('admin/product', {
      titleSite: 'ShopOH'
    });
  } catch (err) {
    next(err);
  }
};
