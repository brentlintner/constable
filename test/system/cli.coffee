child_process = require "child_process"
path = require "path"
chai = require "chai"
sinon_chai = require "./../helpers/sinon_chai"
pkg = require "./../../package"
cli = require "./../../lib/cli"
cli_bin = path.resolve path.join(__dirname, "..", "..", "bin", "cli")
root_dir = path.resolve path.join(__dirname, "..", "..")
bower_test_dir = path.resolve path.join(__dirname, "..", "fixtures", "json")
istanbul = path.resolve path.join(__dirname, "..", "..",
                                  "node_modules", ".bin", "istanbul")
expect = chai.expect
exec_opts =
  cwd: bower_test_dir

with_cov = (count, args=[]) ->
  "#{istanbul} test --dir #{root_dir}/coverage/system-#{count}
   --root #{root_dir} --print none
   #{cli_bin} -- #{args.join ' '}"

describe "system :: cli", ->
  test_count = 0

  afterEach -> test_count += 1

  describe "smoke tests", ->
    argv = ["node", "script"]

    it "can call the cli as a user would (for help)", (done) ->
      child_process.exec with_cov(test_count), exec_opts,
        (error, stdout, stderr) ->
          expect(error).not.to.be.ok
          done()

    it "can list packages without error", (done) ->
      child_process.exec with_cov(test_count, ["-l"]),
        exec_opts,
        (error, stdout, stderr) ->
          expect(error).not.to.be.ok
          done()

    # TODO: test json file, and then reset?
    xit "can update packages", (done) ->
      child_process.exec with_cov(test_count, ["-u"]),
        (error, stdout, stderr) ->
          done()
        , cwd: bower_test_dir
