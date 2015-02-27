logger = require "./logger"
pkg = require "./../package"
constable = require "./index"
app = require "commander"
_ = require "lodash"
log = logger.create "cli"

pad_string = (str, padding=20) ->
  len = if str then str.length else 0
  _.each [len..padding], () -> str += " "
  str

run = (app) ->
  logger.verbose(true) if app.verbose
  logger.quiet() if app.quiet

  if app.list
    constable.list (available) ->
      if available.length > 0
        log.info "available packages to update:"
        log.info()

        _.each available, (dep) ->
          log.info "  #{pad_string dep.name}
                      #{pad_string dep.version, 10} =>
                      #{dep.latest}"
      else
        log.info "no updated packages available"


  if app.update
    opts = tabbing: app.tabbing

    constable.update opts, (updated) ->
      if updated.length > 0
        log.info "updating all packages"
        log.info()
        _.each updated, (dep) ->
          log.info "  #{pad_string dep.name}
                      #{pad_string dep.version, 10} =>
                      #{dep.latest}"
      else
        log.info "no packages to update"

configure = ->
  app
    .version pkg.version
    .usage "[options]"
    .option "-l, --list",
            "list available updates"
    .option "-u, --update",
            "update bower.json with the latest available versions"
    .option "-t, --tabbing [number]",
            "number of spaces to use when overwriting bower.json (default=2)"
    .option "-q, --quiet",
            "be wvery wvery quiet."
    .option "-v, --verbose",
            "log all the things."

  app.outputHelp() if not process.argv.slice(2).length

interpret = (argv) ->
  configure()
  app.parse argv
  run app

module.exports =
  interpret: interpret
