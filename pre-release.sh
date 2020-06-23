#!/bin/bash

# Configuration
JQUERY_VERSION="3.5.1"
WORKDIR=./installations/pre-release

rm -rf $WORKDIR/*

cd $WORKDIR

npm link interactiveimagejs

cp -R ../../template/assets ./
cp ../../template/index.html ./

CSS_FILE="node_modules\\\interactiveimagejs\\\dist\\\interactive-image.min.css"
JS_FILE="node_modules\\\interactiveimagejs\\\dist\\\interactive-image.min.js"
JQUERY_FILE_START="https:\\/\\/ajax.googleapis.com\\/ajax\\/libs\\/jquery\\/"
JQUERY_FILE_END="\\/jquery.min.js"
JQUERY_FILE_VERSION=$JQUERY_FILE_START$JQUERY_VERSION$JQUERY_FILE_END

sed -i 's/CSSFILE/'$CSS_FILE'/g' ./index.html
sed -i 's/JSFILE/'$JS_FILE'/g' ./index.html
sed -i 's/JQUERYFILE/'$JQUERY_FILE_VERSION'/g' ./index.html

cd -