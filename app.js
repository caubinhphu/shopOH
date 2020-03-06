require('dotenv').config();

const express = require('express');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');

// Router
const customerAccountRoute = require('./routers/personal-customer.router');
const customerProductRoute = require('./routers/product-customer.router')
const customerCartRoute = require('./routers/cart-customer.router');

const app = express();

// set view engine - template engine
app.set('views', './views');
app.set('view engine', 'pug');

app.use(express.static('public'));
app.use(bodyParser.urlencoded( { extended: true } ));
app.use(bodyParser.json());
app.use(cookieParser(process.env.SETRECT));

app.use('/', customerProductRoute);
app.use('/account', customerAccountRoute);
app.use('/cart', customerCartRoute);

// handle errors
app.use((err, req, res, next) => {
  if (err)
    console.log(err);
    res.send(err.message);
});

app.listen(3000, () => console.log('Server is connected'));