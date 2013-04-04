chai = require "chai"

should = chai.should()

Application = require("../../../src/app").Application

describe "Storage Item", ->
	it "should exist", ->
		should.exist Application.StorageItem

	it "should have a default index, key and value", ->
		storageItem = new Application.StorageItem()
		storageItem.get("index").should.equal 0
		storageItem.get("key").should.be.empty
		storageItem.get("value").should.be.empty