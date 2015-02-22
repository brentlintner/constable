logger = require "./../../lib/logger"
log = logger.create "testing"

describe "integration :: logger", ->
  describe "smoke tests", ->
    afterEach logger.default

    it 'can toggle quiet', ->
      logger.quiet()
      logger.default()

    it 'can toggle verbose', ->
      logger.verbose true
      logger.verbose false
