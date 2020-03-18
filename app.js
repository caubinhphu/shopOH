require('dotenv').config();

const express = require('express');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const morgan = require('morgan');
const flash = require('connect-flash');
const session = require('express-session');

// Require router
const customerAccountRoute = require('./routers/personal-customer.router');
const customerProductRoute = require('./routers/product-customer.router');
const customerCartRoute = require('./routers/cart-customer.router');
const authRouter = require('./routers/auth.router');

// middleware
const authMiddleware = require('./middlewares/auth.middleware');
const usernameMiddleware = require('./middlewares/usermame.middleware');

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

// morgan logger
app.use(morgan('dev'));
app.use(
  session({
    secret: 'sadfalsd&^#$SDFGSDsdf*%&HDSARF',
    resave: false,
    saveUninitialized: true
  })
);
app.use(flash());

// route
app.use('/', usernameMiddleware, customerProductRoute);
app.use('/login', authRouter);
app.use('/account', authMiddleware, usernameMiddleware, customerAccountRoute);
app.use('/cart', authMiddleware, usernameMiddleware, customerCartRoute);

// handle errors
app.use((err, req, res, next) => {
  if (err) console.log(err);
  res.send(err.message);
});

app.listen(process.env.PORT || 3000, () => console.log('Server is connected'));
