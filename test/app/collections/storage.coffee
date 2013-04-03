chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

Application = require "../../../src/app/collections/storage"

describe "Storage", ->
	it "should exist in the namespace", ->
		should.exist Application.Storage