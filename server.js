var express = require("express");
var app = express();

app.use('/', express.static(__dirname + "/src"));
app.listen(1701);

console.log("Now you can open your browser on http://localhost:1701");