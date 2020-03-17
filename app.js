require('dotenv').config();

const express = require('express');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const morgan = require('morgan');

// Require router
const customerAccountRoute = require('./routers/personal-customer.router');
const customerProductRoute = require('./routers/product-customer.router');
const customerCartRoute = require('./routers/cart-customer.router');
const authRouter = require('./routers/auth.router');

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

// route
app.use('/', customerProductRoute);
app.use('/login', authRouter);
app.use('/account', customerAccountRoute);
app.use('/cart', customerCartRoute);

// handle errors
app.use((err, req, res, next) => {
  if (err) console.log(err);
  res.send(err.message);
});

app.listen(process.env.PORT || 3000, () => console.log('Server is connected'));
