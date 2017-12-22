require("../static/styles.css");

const wrapper = document.getElementById("elm");
const app = require("../elm/Main").Main.embed(wrapper);

app.ports.resizeInput.subscribe(() => {
    const input = document.getElementById("input");
    input.style.height = "calc(" + input.scrollHeight + "px + 2em)";
});