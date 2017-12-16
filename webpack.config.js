"use strict";

const path = require("path");
const merge = require("webpack-merge");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const UglifyJsPlugin = require("uglifyjs-webpack-plugin");

const entryPath = path.join(__dirname, "src/static/index.js");
const outputPath = path.join(__dirname, "dist");

const defaultConfig = {
    context: __dirname,
    entry: entryPath,
    output: {
        path: outputPath,
        filename: "static/js/[name].js",
    },
    resolve: {
        extensions: [".js", ".elm"],
        modules: ["node_modules"]
    },
    module: {
      rules: [{
          test: /\.css$/,
          use: ["style-loader", "css-loader"]
      }]
    },
    plugins: [
        new HtmlWebpackPlugin({
            template: "src/static/index.html",
            inject: "body",
            filename: "index.html"
        })
    ]
};

const devConfig = {
    entry: [
        "webpack-dev-server/client?http://localhost:8080",
        entryPath
    ],
    devServer: {
        contentBase: path.join(__dirname, "src"),
        hot: true
    },
    module: {
        rules: [{
            test: /\.elm$/,
            exclude: [/elm-stuff/, /node_modules/],
            use: [{
                loader: "elm-webpack-loader",
                options: {
                    verbose: true,
                    warn: true,
                    debug: true
                }
            }]
        }]
    }
};

const prodConfig = {
    module: {
        rules: [{
            test: /\.elm$/,
            exclude: [/elm-stuff/, /node_modules/],
            use: "elm-webpack-loader"
        }]
    },
    plugins: [
        new UglifyJsPlugin()
    ]
};

const isProd = process.env.NODE_ENV === "production" || process.env.npm_lifecycle_event === "build";
const extraConfig = isProd ? prodConfig : devConfig;

module.exports = merge(defaultConfig, extraConfig);