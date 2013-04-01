chai = require "chai"
should = chai.should()

#chai.Assertion.includeStack = true;

Application = require "../../src/app/application"

describe "Application", ->
	it "should exist as a variable for the Namespace", ->
		should.exist Application