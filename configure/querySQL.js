const mysql = require('mysql');

const pool = mysql.createPool(require('./keyConnectDB'));

module.exports = (sqlString, values) => {
  return new Promise((resolve, reject) => {
    pool.getConnection((err, connection) => {
      if (err) {
        reject(err);
      } else {
        connection.query(sqlString, values, (error, results, fields) => {
          if (error) {
            reject(error);
          } else {
            connection.destroy();
            resolve(results);
          }
        });
      }
    });
  });
}