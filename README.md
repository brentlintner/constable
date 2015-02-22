> # constable [![Circle CI](https://circleci.com/gh/brentlintner/constable.svg?style=svg)](https://circleci.com/gh/brentlintner/constable)
> Update your [bower](http://bower.io) dependencies to their latest version.

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

## Gotchas

Data returned via the `bower list` command (which is used by `constable`) can be
different than what your actual `bower.json` specifies, notably when you:

1. Don't actually have the package installed.
2. Have not run `bower install` after updating versions in `bower.json`.
3. Have dependencies specified as `~x.y.1` but have `> x.y.1` installed.

Essentially, things work out best if you have explicit versions set.

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

## Can't Bower Do This?

Bower does support updating dependencies via `bower update`,
but not, it seems, when they are "frozen".

In the future, it may be prudent to update or submit an issue to
`bower` itself, or even `npm-police` to do this, vs have another project.

In the meantime, I created this to do the simple task for writing
the latest (frozen) versions to a `bower.json` project file.
