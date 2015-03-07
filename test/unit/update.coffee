mimus = require "mimus"
sinon_chai = require "./../helpers/sinon_chai"
update = mimus.require "./../../lib/update", __dirname, []

# TODO
# check tabbing writes branch
# check when no packages to update
xdescribe "unit :: update", ->
