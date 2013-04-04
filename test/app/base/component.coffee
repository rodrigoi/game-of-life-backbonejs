chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

Backbone = require("../../../src/app").Backbone

describe "Base Component Class", ->
	it "should call initialize in the contructor class", ->
		initializeStub = sinon.stub Backbone.Component.prototype, "initialize"
		baseComponent = new Backbone.Component();
		initializeStub.should.have.been.calledOnce
		initializeStub.restore()

	it "should provide a chainable initialize method", ->
		baseComponent = new Backbone.Component();
		baseComponent.initialize().should.equal baseComponent

	it "should borrow the extend object from Backbone", ->
		Backbone.Component.extend.should.exists