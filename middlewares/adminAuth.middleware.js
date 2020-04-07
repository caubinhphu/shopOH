module.exports = (req, res, next) => {
  let aid = req.signedCookies.aid;
  if (!aid) {
    return res.redirect('/adminAuth');
  } else if (aid !== process.env.ADMIN_ID) {
    return res.redirect('/adminAuth');
  }
  next();
};
