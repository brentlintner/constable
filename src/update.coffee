fs = require "fs"
path = require "path"
_ = require "lodash"
logger = require "./logger"
list = require "./list"
log = logger.create "update"

update_cwd_deps = (opts={}, cb) ->
  bower_json = path.join(process.cwd(), "bower.json")
  tabbing = opts.tabbing || 2
  file = require bower_json
  dependencies = file.dependencies
  devDependencies = file.devDependencies
  updated = []

  list.available (pkgs) ->
    _.each dependencies, (version, name) ->
      pkg = _.find pkgs, (pkg) -> pkg.name == name
      if pkg
        updated.push pkg
        dependencies[name] = pkg.latest

    _.each devDependencies, (version, name) ->
      pkg = _.find pkgs, (pkg) -> pkg.name == name
      if pkg
        updated.push pkg
        devDependencies[name] = pkg.latest

    data = JSON.stringify file, null, tabbing

    fs.writeFileSync bower_json, data

    cb updated


module.exports =
  available: update_cwd_deps
