#!/bin/bash

# Configuration
INTERACTIVE_IMAGE_VERSION="2.7.0"
LATEST_JQUERY_VERSION="3.5.1"
JQUERY_VERSIONS=("1.7.2" "1.12.4" "2.2.4" "3.5.1")

# 1. Setup

WORKDIR=./installations
WORKDIR_DOWNLOAD=$WORKDIR/download
WORKDIR_NPM=$WORKDIR/npm
WORKDIR_YARN=$WORKDIR/yarn
WORKDIR_JSDELIVR=$WORKDIR/jsdelivr
WORKDIR_UNPKG=$WORKDIR/unpkg

rm -rf $WORKDIR/*
mkdir $WORKDIR_DOWNLOAD
mkdir $WORKDIR_NPM
mkdir $WORKDIR_YARN
mkdir $WORKDIR_JSDELIVR
mkdir $WORKDIR_UNPKG

touch package.json
echo "{\"dependencies\": {\"interactiveimagejs\": \"$INTERACTIVE_IMAGE_VERSION\", \"jquery\": \"$LATEST_JQUERY_VERSION\"}}" > package.json

# 2. Download

echo "Generating Download directory..."

cd $WORKDIR_DOWNLOAD
wget https://github.com/jpchateau/Interactive-Image/archive/v$INTERACTIVE_IMAGE_VERSION.zip
unzip v$INTERACTIVE_IMAGE_VERSION.zip
cp -R Interactive-Image-$INTERACTIVE_IMAGE_VERSION/dist/* ./
rm -rf Interactive-Image-$INTERACTIVE_IMAGE_VERSION v$INTERACTIVE_IMAGE_VERSION.zip
cp -R ../../template/assets ./

CSS_FILE="interactive-image.min.css"
JS_FILE="interactive-image.min.js"
JQUERY_FILE_START="https:\\/\\/ajax.googleapis.com\\/ajax\\/libs\\/jquery\\/"
JQUERY_FILE_END="\\/jquery.min.js"

for INDEX in ${!JQUERY_VERSIONS[*]}
do
    VERSION="${JQUERY_VERSIONS[$INDEX]}"
    JQUERY_FILE_VERSION=$JQUERY_FILE_START$VERSION$JQUERY_FILE_END

    cp ../../template/index.html ./index$VERSION.html
    sed -i 's/CSSFILE/'$CSS_FILE'/g' ./index$VERSION.html
    sed -i 's/JSFILE/'$JS_FILE'/g' ./index$VERSION.html
    sed -i 's/JQUERYFILE/'$JQUERY_FILE_VERSION'/g' ./index$VERSION.html
done

cd ../..

# 3. NPM

echo "Generating NPM directory..."

CSS_FILE="node_modules\\\interactiveimagejs\\\dist\\\interactive-image.min.css"
JS_FILE="node_modules\\\interactiveimagejs\\\dist\\\interactive-image.min.js"
JQUERY_FILE="node_modules\\\jquery\\\dist\\\jquery.min.js"

cd $WORKDIR_NPM

cp -R ../../template/assets ./
cp ../../template/index.html ./
cp ../../package.json ./

echo "npm version: "
npm -v
npm install

sed -i 's/CSSFILE/'$CSS_FILE'/g' ./index.html
sed -i 's/JSFILE/'$JS_FILE'/g' ./index.html
sed -i 's/JQUERYFILE/'$JQUERY_FILE'/g' ./index.html

cd ../..

# 4. Yarn

echo "Generating Yarn directory..."

cd $WORKDIR_YARN

cp -R ../../template/assets ./
cp ../../template/index.html ./
cp ../../package.json ./

echo "Yarn version: "
yarn -v
yarn install

sed -i 's/CSSFILE/'$CSS_FILE'/g' ./index.html
sed -i 's/JSFILE/'$JS_FILE'/g' ./index.html
sed -i 's/JQUERYFILE/'$JQUERY_FILE'/g' ./index.html

cd ../..

# 5. jsDelivr

echo "Generating jsDelivr directory..."

cd $WORKDIR_JSDELIVR

cp -R ../../template/assets ./
cp ../../template/index.html ./

CDN_HOST="https:\\/\\/cdn.jsdelivr.net\\/"

CSS_FILE=$CDN_HOST"npm\\/interactiveimagejs@$INTERACTIVE_IMAGE_VERSION\\/dist\\/interactive-image.min.css"
JS_FILE=$CDN_HOST"npm\\/interactiveimagejs@$INTERACTIVE_IMAGE_VERSION\\/dist\\/interactive-image.min.js"
JQUERY_FILE_START="https:\\/\\/ajax.googleapis.com\\/ajax\\/libs\\/jquery\\/"
JQUERY_FILE_END="\\/jquery.min.js"

JQUERY_FILE=$JQUERY_FILE_START$LATEST_JQUERY_VERSION$JQUERY_FILE_END

sed -i 's/CSSFILE/'$CSS_FILE'/g' ./index.html
sed -i 's/JSFILE/'$JS_FILE'/g' ./index.html
sed -i 's/JQUERYFILE/'$JQUERY_FILE'/g' ./index.html

cd ../..

# 6. unpkg

echo "Generating unpkg directory..."

cd $WORKDIR_UNPKG

cp -R ../../template/assets ./
cp ../../template/index.html ./

CDN_HOST="https:\\/\\/unpkg.com\\/"

CSS_FILE=$CDN_HOST"interactiveimagejs@$INTERACTIVE_IMAGE_VERSION\\/dist\\/interactive-image.min.css"
JS_FILE=$CDN_HOST"interactiveimagejs@$INTERACTIVE_IMAGE_VERSION\\/dist\\/interactive-image.min.js"
JQUERY_FILE_START="https:\\/\\/ajax.googleapis.com\\/ajax\\/libs\\/jquery\\/"
JQUERY_FILE_END="\\/jquery.min.js"

JQUERY_FILE=$JQUERY_FILE_START$LATEST_JQUERY_VERSION$JQUERY_FILE_END

sed -i 's/CSSFILE/'$CSS_FILE'/g' ./index.html
sed -i 's/JSFILE/'$JS_FILE'/g' ./index.html
sed -i 's/JQUERYFILE/'$JQUERY_FILE'/g' ./index.html

cd ../..

# End

rm package.json