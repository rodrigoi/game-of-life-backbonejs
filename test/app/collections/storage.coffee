chai = require "chai"

should = chai.should()

Application = require "../../../src/app/collections/storage"

describe "Storage", ->
	it "should exist in the namespace", ->
		should.exist Application.Storage