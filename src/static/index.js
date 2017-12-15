require("style-loader!./styles.css");

var Elm = require("../elm/Main");
Elm.Main.embed(document.getElementById("main"));