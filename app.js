require('dotenv').config();

const express = require('express');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const morgan = require('morgan');
const flash = require('connect-flash');
const session = require('express-session');
const methodOverride = require('method-override');

// Require router
const customerAccountRoute = require('./routers/personal-customer.router');
const customerProductRoute = require('./routers/product-customer.router');
const customerCartRoute = require('./routers/cart-customer.router');
const authRoute = require('./routers/auth.router');
const checkoutRoute = require('./routers/checkout.router');
const adminRoute = require('./routers/admin.route');
const adminAuthRoute = require('./routers/adminAuth.route');

// middleware
const authMiddleware = require('./middlewares/auth.middleware');
const usernameMiddleware = require('./middlewares/usermame.middleware');
const adminAuthMiddleware = require('./middlewares/adminAuth.middleware');

// init app
const app = express();

// set view engine - template engine
app.set('views', './views');
app.set('view engine', 'pug');

// public static file directory
app.use(express.static('public'));

// body parse json + ulrencoded
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// cookie parse with secret
app.use(cookieParser(process.env.SECRET_COOKIE));

// method htttp override
app.use(
  methodOverride((req, res) => {
    if (req.body && typeof req.body === 'object' && '_method' in req.body) {
      // look in urlencoded POST bodies and delete it
      let method = req.body._method;
      delete req.body._method;
      return method;
    }
  })
);

// morgan logger
app.use(morgan('dev'));
app.use(
  session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: true
  })
);
app.use(flash());

// route
app.use('/', usernameMiddleware, customerProductRoute);
app.use('/login', authRoute);
app.use('/account', authMiddleware, usernameMiddleware, customerAccountRoute);
app.use('/cart', authMiddleware, usernameMiddleware, customerCartRoute);
app.use('/checkout', authMiddleware, usernameMiddleware, checkoutRoute);
app.use('/adminAuth', adminAuthRoute);
app.use('/admin', adminAuthMiddleware, adminRoute);

// handle errors
app.use((err, req, res, next) => {
  if (err) console.log(err);
  res.send(err.message);
});

app.listen(process.env.PORT || 3000, () => console.log('Server is connected'));
