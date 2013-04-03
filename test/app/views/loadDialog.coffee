chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

describe "Load Dialog View", ->
	it "should have some defautls"