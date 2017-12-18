"use strict";

const path = require("path");
const merge = require("webpack-merge");

const HtmlWebpackPlugin = require("html-webpack-plugin");
const HtmlWebpackInlineSourcePlugin = require("html-webpack-inline-source-plugin");
const ExtractTextPlugin = require("extract-text-webpack-plugin");

const defaultConfig = {
    entry: path.resolve(__dirname, "src/static/index.js"),
    output: {
        path: path.resolve(__dirname, "dist/"),
        filename: "bundle.js",
    },
    resolve: {
        extensions: [".js", ".elm"],
        modules: ["node_modules"]
    },
    module: {
      rules: [{
          test: /\.css$/,
          use: ExtractTextPlugin.extract({
              fallback: "style-loader",
              use: "css-loader"
          })
      }]
    },
    plugins: [
        new ExtractTextPlugin("bundle.css")
    ]
};

const devConfig = {
    module: {
        rules: [{
            test: /\.elm$/,
            exclude: ["elm-stuff", "node_modules"],
            use: [{
                loader: "elm-webpack-loader",
                options: { verbose: true, warn: true, debug: true }
            }]
        }]
    },
    plugins: [
        new HtmlWebpackPlugin({ template: "src/static/index.html" })
    ]
};

const prodConfig = {
    module: {
        rules: [{
            test: /\.elm$/,
            exclude: ["elm-stuff", "node_modules"],
            use: "elm-webpack-loader"
        }]
    },
    plugins: [
        new HtmlWebpackPlugin({
            template: "src/static/index.html",
            inlineSource: /.(js|css)$/
        }),
        new HtmlWebpackInlineSourcePlugin()
    ]
};

const isProd = process.env.NODE_ENV === "production" || process.env.npm_lifecycle_event === "build"
const envSpecificConfig = isProd ? prodConfig : devConfig;

module.exports = merge(defaultConfig, envSpecificConfig);