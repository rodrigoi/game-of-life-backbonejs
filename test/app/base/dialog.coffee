chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

Backbone = require("../../../src/app").Backbone

describe "Base Dialog Class", ->
	it "should exist", ->
		Backbone.Dialog.should.exist

	it "should provide an initialize method that's called on the constructor", ->
		initializeStub = sinon.stub Backbone.Dialog.prototype, "initialize"
		dialog = new Backbone.Dialog()
		initializeStub.should.have.been.calledOnce
		initializeStub.restore()

	it "should accept an options object in the constructor, and use it to set global properties", ->
		dialog = new Backbone.Dialog
			world: 1, storage: 1

		dialog.world.should.exist
		dialog.storage.should.exist