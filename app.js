require('dotenv').config();

const express = require('express');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');

const querySQL = require('./configure/querySQL');

const customerRoute = require('./routers/customer.router');

const app = express();

app.set('views', './views');
app.set('view engine', 'pug');

app.use(express.static('public'));
app.use(bodyParser.urlencoded( { extended: true } ));
app.use(bodyParser.json());
app.use(cookieParser(process.env.SETRECT));

app.get('/', async (req, res, next) => {
  try {
    res.render('customer/personal-address', {
      titleSite: 'ShopOH'
    })
  } catch(err) { next(err); }
});

app.use('/account', customerRoute);

app.use((err, req, res, next) => {
  if (err)
    res.send(err.message);
});

app.listen(3000, () => console.log('Server is connected'));