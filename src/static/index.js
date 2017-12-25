require("../static/styles.css");

var wrapper = document.getElementById("elm");
var app = require("../elm/Main").Main;

app.embed(wrapper);