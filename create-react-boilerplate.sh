#!/bin/bash

mkdir -p $1
cd $1

mkdir -p dist

mkdir -p src
mkdir -p src/app
mkdir -p src/app/js
mkdir -p src/app/js/components
mkdir -p src/app/js/constants
mkdir -p src/app/js/utils
mkdir -p src/app/sass

mkdir -p __tests__
mkdir -p __tests__/component
mkdir -p __tests__/unit

touch src/app/js/index.js

echo "
import { configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
configure({ adapter: new Adapter() });
" > src/setupTests.js

echo "
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}
" > src/app/sass/default.scss

echo "
<!DOCTYPE html>
<html>
  <head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
    <title>Practice</title>
  </head>
  <body>
    <div id=\"root\"></div>
  </body>
</html>
" > src/app/index.html

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
    app: './src/app/js/index.js',
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
      template: './src/app/index.html'
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
    modules: [path.resolve(__dirname, './src'), path.resolve(__dirname, './node_modules')],
    extensions: ['.js', '.jsx']
  }
}; " > webpack.config.js

echo "
{
    \"presets\": [\"@babel/preset-react\", \"@babel/env\"]
}
" > .babelrc

echo "
{
  \"name\": \"project-boilerplate\",
  \"version\": \"1.0.0\",
  \"private\": true,
  \"license\": \"MIT\",
  \"scripts\": {
    \"build\": \"webpack\",
    \"start\": \"webpack-dev-server --open\",
    \"test\": \"jest\"
  },
  \"jest\": {
    \"setupFilesAfterEnv\": [\"<rootDir>/src/setupTests\"],
    \"modulePaths\": [
      \"<rootDir>/src\"
    ]
  },
  \"devDependencies\": {
    \"@babel/core\": \"^7.5.4\",
    \"@babel/preset-env\": \"^7.5.4\",
    \"@babel/preset-react\": \"^7.0.0\",
    \"babel-jest\": \"^24.8.0\",
    \"babel-loader\": \"^8.0.6\",
    \"clean-webpack-plugin\": \"^3.0.0\",
    \"css-loader\": \"^3.0.0\",
    \"enzyme\": \"^3.10.0\",
    \"enzyme-adapter-react-16\": \"^1.14.0\",
    \"file-loader\": \"^4.0.0\",
    \"html-webpack-plugin\": \"^3.2.0\",
    \"jest\": \"^24.8.0\",
    \"node-sass\": \"^4.12.0\",
    \"react-test-renderer\": \"^16.8.6\",
    \"sass-loader\": \"^7.1.0\",
    \"style-loader\": \"^0.23.1\",
    \"webpack\": \"^4.35.0\",
    \"webpack-cli\": \"^3.3.4\",
    \"webpack-dev-server\": \"^3.7.2\"
  },
  \"dependencies\": {
    \"react\": \"^16.8.6\",
    \"react-dom\": \"^16.8.6\",
    \"styled-components\": \"^4.3.2\"
  }
} " > package.json

yarn

printf "\n"
echo "React JS project created in $1. Happy hacking!"
printf "\n"