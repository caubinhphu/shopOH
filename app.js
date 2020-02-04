const express = require('express');

const app = express();

app.get('', (req, res, next) => {
  res.send('Hello');
});


app.listen(3000, () => console.log('Server is connected'));