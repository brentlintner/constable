mimus = require "mimus"
sinon_chai = require "./../helpers/sinon_chai"
list = mimus.require "./../../lib/list", __dirname, []

# TODO
# check when not packages available
xdescribe "unit :: list", ->
