path = require "path"
fs = require "fs"
wrench = require "wrench"
Mocha = require "mocha"
specs = path.join __dirname, "..", "test"

find = (spec_type) ->
  wrench
    .readdirSyncRecursive path.join(specs, spec_type)
    .filter (p) -> /\.js/.test p
    .map (p) -> path.resolve (path.join specs, spec_type, p)

all_specs = ->
  find("unit")
    .concat find("integration")
    .concat find("system")

run = (type) ->
  runner = new Mocha
    ui: "bdd"
    reporter: "spec"
    slow: 10000
    timeout: 30000

  runner.files = all_specs()

  runner.run (errors) ->
    process.exit if errors > 0 then 1 else 0

module.exports =
  run: run
