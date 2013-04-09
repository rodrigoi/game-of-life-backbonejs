chai = require "chai"

should = chai.should()

Application = require("../../../src/app").Application

describe "Storage Item", ->
	it "should exist", ->
		should.exist Application.StorageItem

	it "should have a default name and pattern", ->
		storageItem = new Application.StorageItem()
		storageItem.get("name").should.be.empty
		storageItem.get("pattern").should.be.empty