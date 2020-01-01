#!/bin/bash

mkdir -p $1
cd $1

mkdir -p dist

mkdir -p src/js
touch src/js/index.js

mkdir -p src/sass
touch src/sass/style.scss


echo "<!DOCTYPE html>
<html>
  <head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
    <title>$1</title>
  </head>
  <body>
    <div id=\"root\"></div>
  </body>
</html>
" > src/index.html

echo "
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const webpack = require('webpack');

module.exports = {
  mode: 'development',
  devtool: 'inline-source-map',
  devServer: {
    contentBase: './dist'
  },
  entry: {
    app: './src/js/index.js',
  },
  output: {
    filename: '[name].bundle.js',
    path: path.resolve(__dirname, 'dist'),
    publicPath: '/'
  },
  plugins: [
    new CleanWebpackPlugin(),
    new HtmlWebpackPlugin({
      title: '$1',
      template: './src/index.html'
    }),
    new webpack.HotModuleReplacementPlugin()
  ],
  module: {
    rules: [
      {
        test: /\.scss$/,
        use: [
          'style-loader',
          'css-loader',
          'sass-loader'
        ]
      },
      {
         test: /\.(png|svg|jpg|gif)$/,
         use: [
           'file-loader'
         ]
       }
    ]
  },
  resolve: {
    modules: [path.resolve(__dirname, './'), path.resolve(__dirname, './node_modules')],
    extensions: ['.js']
  }
}; " > webpack.config.js

echo "
module.exports = {
  presets: [
    [
      \"@babel/preset-env\",
      {
        targets: {
          node: \"current\"
        }
      }
    ]
  ]
};
" > babel.config.js

echo "
{
  \"name\": \"project-boilerplate\",
  \"version\": \"1.0.0\",
  \"private\": true,
  \"license\": \"MIT\",
  \"scripts\": {
    \"build\": \"webpack\",
    \"start\": \"webpack-dev-server --open\"
  },
  \"devDependencies\": {
    \"@babel/core\": \"^7.4.5\",
    \"jest\": \"^24.8.0\",
    \"@babel/preset-env\": \"^7.4.5\",
    \"babel-jest\": \"^24.8.0\",
    \"clean-webpack-plugin\": \"^3.0.0\",
    \"css-loader\": \"^3.0.0\",
    \"file-loader\": \"^4.0.0\",
    \"html-webpack-plugin\": \"^3.2.0\",
    \"node-sass\": \"^4.12.0\",
    \"sass-loader\": \"^7.1.0\",
    \"style-loader\": \"^0.23.1\",
    \"webpack\": \"^4.35.0\",
    \"webpack-cli\": \"^3.3.4\",
    \"webpack-dev-server\": \"^3.7.2\"
  }
} " > package.json

yarn

printf "\n"
echo "Vanilla JS project created in $1. Happy hacking!"
printf "\n"