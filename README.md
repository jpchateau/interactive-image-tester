# Interactive Image Tester

The aim of this project is to test [Interactive Image](https://github.com/jpchateau/Interactive-Image) against different contexts.

Tested features:
* Text item
* Picture item
* Audio item (mp3)
* Video item (mp4)
* Provider item (Youtube)
* Multiple instances
* Different options (share box, sticky items, HTML markup)

## Download

*Installation by downloading files from Github.*

Tested jQuery versions:

* jquery 1.7.2 (minimum version)
* jquery 1.12.4 (latest 1.x version)
* jquery 2.2.4 (latest 2.x version)
* jquery 3.5.1 (latest version)

## NPM

*Installation via npm package manager.*

## Yarn

*Installation via Yarn package manager.*

## Requirements

* wget
* unzip
* npm
* yarn

## Usage

Execute the script:

```bash
$ ./app.sh
```

The results of the different installations are located in the `installations` directory.  
Browse them and open the `index.html` files in your browser.

In order to test a version of the package that is still not published:

```bash
$ sudo npm link # in the package folder before to execute the pre-release script.
$ ./pre-release.sh
```

## Frameworks

**Interactive Image** can be used with different frameworks.  
Browse the `frameworks` directory to see how to use the jQuery plugin with:
* Angularjs
* Symfony 5.x with Webpack Encore