require("../static/styles.css");

var wrapper = document.getElementById("elm");
var app = require("../elm/Main").Main.embed(wrapper);

app.ports.resizeInput.subscribe(function() {
    var input = document.getElementById("input");
    input.style.height = "calc(" + input.scrollHeight + "px + 2em)";
});