chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

describe "Save Dialog View", ->
	it "should have some defaults"