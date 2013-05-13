var express = require('express');
var app = express();

app.use(express.bodyParser());

app.post('/', function(req, res){
  var id = req.body['message_id'];
  res.setHeader('Content-Type', 'application/json');
  res.end(JSON.stringify({ "mesage_id": id}));
});
app.listen(3000);
