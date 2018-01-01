// This file is the entry point for the whole application.

// The entry point for all Less code.
import "./styles.less";

// The entry point for all Elm code.
var app = require("../elm/Main").Main;
app.embed(document.getElementById("elm"));