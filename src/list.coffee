bower = require "bower"
_ = require "lodash"
logger = require "./logger"
log = logger.create "replace"

latest = (dep) ->
  if dep.update && dep.update.latest
    dep.update.latest
  else "?"

version = (dep) ->
  if dep.update && dep.update.target
    dep.update.target
  else if dep.pkgMeta && dep.pkgMeta.version
    dep.pkgMeta.version
  else "?"

get_cwd_deps = (cb) ->
  available = []

  bower
    .commands.list()
    .on "end", (results) ->
      cb _.filter _.map(results.dependencies, (dep, name) ->
        name: name
        version: version dep
        latest: latest dep
      ), (dep) -> dep.version != dep.latest

module.exports =
  available: get_cwd_deps
