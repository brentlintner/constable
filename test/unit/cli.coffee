mimus = require "mimus"
commander = require "commander"
sinon_chai = require "./../helpers/sinon_chai"
cli = mimus.require "./../../lib/cli", __dirname, []

describe "unit :: cli", ->
  argv = ["node", "script"]
  log = null

  beforeEach ->
    log = mimus.get cli, "log"
    mimus.stub log, "info"

  afterEach mimus.restore

  describe "interpreting process argv", ->
    it "logs help without any errors", ->
      mimus.stub process.stdout, "write"
      mimus.stub process.stderr, "write"
      mimus.stub process, "exit"

      cli.interpret argv.concat ["-h"]

      process.stdout.write.should.have.been.called
      process.exit.should.have.been.calledWith 0

      process.stdout.write.restore()
      process.stderr.write.restore()
      process.exit.restore()

    # TODO
    xdescribe "printing a list of dependencies", ->
    xdescribe "printing an update of dependencies", ->
    xdescribe "setting quiet logging", ->
    xdescribe "setting verbose logging", ->
