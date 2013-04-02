chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

Application = require "../../../src/app/models/storageItem"

describe "Storage Item", ->
	it "should exist", ->
		should.exist Application.StorageItem

	it "should have a default index, key and value", ->
		storageItem = new Application.StorageItem()
		storageItem.get("index").should.equal 0
		storageItem.get("key").should.be.empty
		storageItem.get("value").should.be.empty