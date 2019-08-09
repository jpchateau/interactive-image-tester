#!/bin/bash

WORKDIR=./Tester
INTERACTIVE_IMAGE_VERSION="2.4.0"
JQUERY_VERSIONS=("1.7.2" "1.12.4" "2.2.4" "3.4.1")

# 1. Prepare directories

mkdir -p $WORKDIR/Download
mkdir -p $WORKDIR/NPM
mkdir -p $WORKDIR/Yarn

rm -rf $WORKDIR/Download/*
rm -rf $WORKDIR/NPM/*
rm -rf $WORKDIR/Yarn/*

# 2. Download

cd $WORKDIR/Download
wget https://github.com/jpchateau/Interactive-Image/archive/v$INTERACTIVE_IMAGE_VERSION.zip
unzip v$INTERACTIVE_IMAGE_VERSION.zip
cp -R Interactive-Image-$INTERACTIVE_IMAGE_VERSION/dist/* ./
rm -rf Interactive-Image-$INTERACTIVE_IMAGE_VERSION v$INTERACTIVE_IMAGE_VERSION.zip
cd ../..

echo "Generating Download directory..."

CSS_FILE="interactive-image.min.css"
JS_FILE="interactive-image.min.js"
JQUERY_FILE_START="https://ajax.googleapis.com/ajax/libs/jquery/"
JQUERY_FILE_END="/jquery.min.js"

cp -R ./Template/assets $WORKDIR/Download

for INDEX in ${!JQUERY_VERSIONS[*]}
do
    VERSION="${JQUERY_VERSIONS[$INDEX]}"
    JQUERY_FILE_VERSION=$JQUERY_FILE_START$VERSION$JQUERY_FILE_END

    echo $JQUERY_FILE_VERSION

    cp ./Template/index.html $WORKDIR/Download/index$VERSION.html

    sed -i 's/CSSFILE/'$CSS_FILE'/g' $WORKDIR/Download/index$VERSION.html
    sed -i 's/JSFILE/'$JS_FILE'/g' $WORKDIR/Download/index$VERSION.html
    sed -i 's/JQUERYFILE/'$JQUERY_FILE_VERSION'/g' $WORKDIR/Download/index$VERSION.html
done

# 3. NPM

CSS_FILE="node_modules\\interactiveimagejs\\dist\\interactive-image.min.css"
JS_FILE="node_modules\interactiveimagejs\dist\interactive-image.min.js"
JQUERY_FILE="node_modules\jquery\dist\jquery.min.js"

cp -R ./Template/assets $WORKDIR/NPM
cp ./Template/index.html $WORKDIR/NPM/
cp ./Template/package.json $WORKDIR/NPM/
cd $WORKDIR/NPM
npm -v
npm install
cd ../..

sed -i 's/CSSFILE/'$CSS_FILE'/g' $WORKDIR/NPM/index.html
sed -i 's/JSFILE/'$JS_FILE'/g' $WORKDIR/NPM/index.html
sed -i 's/JQUERYFILE/'$JQUERY_FILE'/g' $WORKDIR/NPM/index.html

# 4. Yarn

cp -R ./Template/assets $WORKDIR/Yarn
cp ./Template/index.html $WORKDIR/Yarn/
cp ./Template/package.json $WORKDIR/Yarn/
cd $WORKDIR/Yarn
yarn -v
yarn install
cd ../..

sed -i 's/CSSFILE/'$CSS_FILE'/g' $WORKDIR/Yarn/index.html
sed -i 's/JSFILE/'$JS_FILE'/g' $WORKDIR/Yarn/index.html
sed -i 's/JQUERYFILE/'$JQUERY_FILE'/g' $WORKDIR/Yarn/index.html
