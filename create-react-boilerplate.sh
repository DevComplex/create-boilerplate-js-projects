#!/bin/bash

mkdir -p $1
cd $1

mkdir -p src
mkdir -p src/js
mkdir -p src/js/components

touch src/js/index.js

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

echo "const path = require('path');
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
       },
       {
        rules: [
          {
            test: /\.(js|jsx)$/,
            exclude: /node_modules/,
            use: {
              loader: 'babel-loader'
            }
          }
        ]
      }
    ]
  },
  resolve: {
    modules: [path.resolve(__dirname, './'), path.resolve(__dirname, './node_modules')],
    extensions: ['.js', '.jsx']
  }
}; " > webpack.config.js

echo "{
  \"presets\": [\"@babel/preset-react\", \"@babel/env\"],
  \"plugins\": [\"@babel/plugin-transform-runtime\", \"@babel/plugin-proposal-class-properties\", \"@babel/plugin-syntax-dynamic-import\"],
}
" > .babelrc

echo "{
  \"name\": \"react-boilerplate\",
  \"version\": \"1.0.0\",
  \"private\": true,
  \"license\": \"MIT\",
  \"scripts\": {
    \"build\": \"webpack\",
    \"start\": \"webpack-dev-server --open\"
  },
  \"devDependencies\": {
    \"@babel/plugin-proposal-class-properties\": \"*\",
    \"@babel/plugin-transform-runtime\": \"*\",
    \"@babel/plugin-syntax-dynamic-import\": \"*\",
    \"@babel/core\": \"^7.5.4\",
    \"@babel/preset-env\": \"^7.5.4\",
    \"@babel/runtime\": \"^7.7.7\",
    \"@babel/preset-react\": \"^7.0.0\",
    \"babel-loader\": \"^8.0.6\",
    \"clean-webpack-plugin\": \"^3.0.0\",
    \"file-loader\": \"^4.0.0\",
    \"html-webpack-plugin\": \"^3.2.0\",
    \"webpack\": \"^4.35.0\",
    \"webpack-cli\": \"^3.3.4\",
    \"webpack-dev-server\": \"^3.7.2\",
    \"css-loader\": \"^3.4.0\",
    \"node-sass\": \"^4.13.0\",
    \"sass-loader\": \"^8.0.0\",
    \"style-loader\": \"^1.1.2\"
  },
  \"dependencies\": {
    \"react\": \"*\",
    \"react-dom\": \"*\",
    \"styled-components\": \"*\"
  }
}" > package.json

yarn

printf "\n"
echo "React JS project created in $1. Happy hacking!"
printf "\n"