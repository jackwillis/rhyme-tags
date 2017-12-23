require("../static/styles.css");

var wrapper = document.getElementById("elm");
var app = require("../elm/Main").Main.embed(wrapper);


// Called by the update function in Main.elm.
// Ensures the page's input textarea is at least as tall as its contents.
//
app.ports.resizeInput.subscribe(function() {
    var input = document.getElementById("input");
    input.style.height = "calc(" + input.scrollHeight + "px + 2em)";
});