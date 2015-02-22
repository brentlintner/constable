fs = require "fs"
path = require "path"
_ = require "lodash"
logger = require "./logger"
list = require "./list"
log = logger.create "update"

parse = (json_path) ->
  json = null

  try
    json = require json_path
  catch err
    if err.code is "MODULE_NOT_FOUND"
      log.error "can not find a bower.json in #{process.cwd()}"
      process.exit 1
    else
      throw err

to_n = (str) ->
  if typeof str == "string" && /[0-9]*/.test str
    Number str
  else str

update_cwd_deps = (opts={}, cb) ->
  bower_json = path.join(process.cwd(), "bower.json")
  tabbing = if opts.tabbing then to_n(opts.tabbing) else 2
  file = parse bower_json
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
