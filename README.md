# constable [![Circle CI](https://circleci.com/gh/brentlintner/constable.svg?style=svg)](https://circleci.com/gh/brentlintner/constable) [![NPM version](https://badge.fury.io/js/constable.svg)](http://badge.fury.io/js/constable) [![ISC License](http://img.shields.io/badge/ISC-License-brightgreen.svg)](https://tldrlegal.com/license/-isc-license) [![Dependency Status](https://david-dm.org/brentlintner/constable.svg)](https://david-dm.org/brentlintner/constable) [![devDependency Status](https://david-dm.org/brentlintner/constable/dev-status.svg)](https://david-dm.org/brentlintner/constable#info=devDependencies)

Update your [bower](http://bower.io) dependencies to their latest version.

## Installation

    npm install -g constable

## Usage

    cd into/bower-project
    constable -h

List the latest versions of your main and dev dependencies, as specified by `bower list`.

    constable -l

This will update your `bower.json` file with the latest package versions.

    constable -u

Then, install them with:

    bower install

## Licensing

This project is licensed under the [ISC](http://en.wikipedia.org/wiki/ISC_license) license.

Any contributions made to this project are made under the current license.

## Hacking

    git clone git@github.com:brentlintner/constable.git
    cd constable
    npm install
    npm test

### On Windows

While the package itself *should* run fine in a Windows environment,
you might need to use something like [msysgit](https://msysgit.github.io) to hack, as a lot
of development based scripts reply on unix like `sh` support.

## Contributions

Current list of [contributors](https://github.com/brentlintner/synt/graphs/contributors).

Any contributions are welcome and appreciated!

All you need to do is submit a [Pull Request](https://github.com/brentlintner/synt/pulls).

1. Please consider tests and code quality before submitting.
2. Please try to keep commits clean, atomic and well explained (for others).

## Issues

Current issue tracker is on [github](https://github.com/brentlintner/synt/issues).

Even if you are uncomfortable with code, an Issue helps!

## Code Of Conduct

This project ascribes to CoralineAda's [contributor covenant](https://github.com/CoralineAda/contributor_covenant).

## Name

In Canada, a `constable` is defined as:

"The lowest rank in most police services."

Which felt appropriate, given the small nature of this project.

This was also a fun project partly inspired by [npm-police](https://github.com/pksunkara/npm-police).
