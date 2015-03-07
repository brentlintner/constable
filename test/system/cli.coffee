child_process = require "child_process"
shell = require "shelljs"
path = require "path"
_ = require "lodash"
fs = require "fs"
chai = require "chai"
sinon_chai = require "./../helpers/sinon_chai"
pkg = require "./../../package"
cli = require "./../../lib/cli"
cli_bin = path.resolve path.join(__dirname, "..", "..", "bin", "cli")
root_dir = path.resolve path.join(__dirname, "..", "..")
bower_test_dir = path.resolve path.join(__dirname, "..", "fixtures", "json")
current_bower_json = require path.join(bower_test_dir, "bower.json")
current_deps = current_bower_json.dependencies
current_dev_deps = current_bower_json.devDependencies
istanbul = path.resolve path.join(__dirname, "..", "..",
                                  "node_modules", ".bin", "istanbul")
expect = chai.expect
exec_opts = cwd: bower_test_dir

with_cov = (count, args=[]) ->
  "#{istanbul} test --dir #{root_dir}/coverage/system-#{count}
   --root #{root_dir} --print none
   #{cli_bin} -- #{args.join ' '}"

describe "system :: cli", ->
  test_count = 0

  run_cmd = (args, done) ->
    child_process.exec with_cov(test_count, args), exec_opts,
      (error, stdout, stderr) ->
        expect(stderr).not.to.be.ok
        expect(error).not.to.be.ok
        done(stdout)

  assert_updates_and_fails_with_no_bower_json = (done) ->
    child_process.exec with_cov(test_count, ["-u"]), cwd: "test",
      (error, stdout, stderr) ->
        expect(stdout).to.match /can not find a bower.json/
        expect(error).to.be.ok
        done(stdout)

  # TODO: could be more granular
  assert_updates = (deps, type, done) ->
    run_cmd ["-u"], (stdout) ->
      updated = JSON.parse(fs.readFileSync(path
                  .join(bower_test_dir, "bower.json")))[type]

      some_differ = false

      _.each updated, (version, name) ->
        if deps[name] != version then some_differ = true

      expect(some_differ).to.eql true

      done()

  afterEach ->
    test_count += 1
    shell.exec "git co -- test/fixtures/json/bower.json"

  after -> shell.exec "git co -- test/fixtures/json/bower.json"

  describe "smoke tests", ->
    argv = ["node", "script"]

    it "can call the cli as a user would (for help)", (done) ->
      run_cmd [], (stdout) -> done()

    it "can call the cli with quiet and not die", (done) ->
      run_cmd ["--quiet"], (stdout) -> done()

    it "can call the cli with verbose and not die", (done) ->
      run_cmd ["--verbose"], (stdout) -> done()

    it "can list packages without error", (done) ->
      run_cmd ["-l"], (stdout) ->
        expect(stdout).to.match new RegExp(current_deps.angular)
        done()

    describe "when updating packages", ->
      it "will log with an error if no bower.json exists", (done) ->
        assert_updates_and_fails_with_no_bower_json -> done()

      it "can update dependency packages without error", (done) ->
        assert_updates current_deps, "dependencies", -> done()

      it "can update dev dependency packages without error", (done) ->
        assert_updates current_dev_deps, "devDependencies", -> done()
