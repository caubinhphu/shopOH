require('dotenv').config();

const express = require('express');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');

// Router
const customerRoute = require('./routers/customer.router');
const indexCustomerRoute = require('./routers/product-customer.router')

const app = express();

// set view engine - template engine
app.set('views', './views');
app.set('view engine', 'pug');

app.use(express.static('public'));
app.use(bodyParser.urlencoded( { extended: true } ));
app.use(bodyParser.json());
app.use(cookieParser(process.env.SETRECT));

app.use('/', indexCustomerRoute);
app.use('/account', customerRoute);

// handle errors
app.use((err, req, res, next) => {
  if (err)
    res.send(err.message);
});

app.listen(3000, () => console.log('Server is connected'));