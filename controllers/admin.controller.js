module.exports.getHome = (req, res, next) => {
  try {
    res.render('admin/common');
  } catch (err) {
    next(err);
  }
};
