chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

Application = require("../../../src/app").Application

describe "Cell", ->
	beforeEach ->
		@cell = new Application.Cell()

	it "should default to x=0 and y=0", ->
		@cell.get("x").should.equal 0
		@cell.get("y").should.equal 0

	it "should start dead", ->
		@cell.get("alive").should.not.be.ok

	it "should start with next state dead", ->
		@cell.get("nextState").should.not.be.ok

	it "should die if it's lonely (no neighbours)", ->
		@cell.set "alive", true
		@cell.set "nextState", true
		@cell.shouldBeAlive 0
		@cell.get("alive").should.be.ok
		@cell.get("nextState").should.not.be.ok

	it "should stay dead if it's lonely (no neighbours)", ->
		@cell.set "alive", false
		@cell.set "nextState", false
		@cell.shouldBeAlive 0
		@cell.get("alive").should.not.be.ok
		@cell.get("nextState").should.not.be.ok

	it "should survive if it's cozy (two or three live neighbours)", ->
		@cell.set "alive", true
		@cell.set "nextState", false
		@cell.shouldBeAlive 2
		@cell.get("alive").should.be.ok
		@cell.get("nextState").should.be.ok

	it "should stay alive if it's cozy", ->
		@cell.set "alive", true
		@cell.set "nextState", false
		@cell.shouldBeAlive 3
		@cell.get("alive").should.be.ok
		@cell.get("nextState").should.be.ok

	it "should come to life if there's love (three neighbours, like on Asimov's 'The Gods Themselves)", ->
		@cell.set "alive", false
		@cell.set "nextState", false
		@cell.shouldBeAlive 3
		@cell.get("alive").should.not.be.ok
		@cell.get("nextState").should.be.ok

	it "should die if there's no more room (more than three living neighbours)", ->
		@cell.set "alive", true
		@cell.set "nextState", true

		@cell.shouldBeAlive 4
		@cell.get("alive").should.be.ok
		@cell.get("nextState").should.not.be.ok

	it "should toggle their state", ->
		@cell.set "alive", false
		@cell.toggleState()
		@cell.get("alive").should.be.ok

		@cell.set "alive", true
		@cell.toggleState()
		@cell.get("alive").should.not.be.ok

	it "should be able to regenerate itself", ->
		@cell.set "alive", false
		@cell.set "nextState", true
		@cell.regenerate()
		@cell.get("alive").should.be.ok

		@cell.set "alive", true
		@cell.set "nextState", true
		@cell.regenerate()
		@cell.get("alive").should.be.ok

		@cell.set "alive", true
		@cell.set "nextState", false
		@cell.regenerate()
		@cell.get("alive").should.not.be.ok

		@cell.set "alive", false
		@cell.set "nextState", false
		@cell.regenerate()
		@cell.get("alive").should.not.be.ok

	it "should bind to the regenerate event to change it's internal status", ->
		regenerateStub = sinon.stub Application.Cell.prototype, "regenerate"
		@cell = new Application.Cell()

		Backbone.trigger "regenerate"
		Backbone.off "regenerate"

		regenerateStub.should.have.been.calledOnce

		regenerateStub.restore()