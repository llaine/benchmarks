var express = require('express');
var app = express();
var pg = require('pg');
var conString = "postgres://postgres:postgres@172.17.0.3/ecratum";


app.get('/', function (req, res) {
  pg.connect(conString, function(err, client, done) {
    if(err) {
      return console.error('error fetching client from pool', err);
    }
    client.query('SELECT id, name from companies LIMIT 10000', function(err, result) {
      done();

      if(err) {
        return console.error('error running query', err);
      }
      
      res.send(result);
    });
  });
});

app.listen(3000, function () {
  console.log('Example app listening on port 3000!');
});
