chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

Backbone = require("../../../src/app").Backbone
Application = require("../../../src/app").Application

describe "Ticker Component", ->
	before ->
		@clock = sinon.useFakeTimers()

	after ->
		@clock.restore()

	beforeEach ->
		@ticker = new Application.Ticker()

	describe "Defaults", ->

		it "should default to 50 ms", ->
			@ticker.tick.should.equal 50

		it "should default to no timer", ->
			should.not.exist @ticker.timer

	describe "Initialize", ->
		it "should call the base class initialize method", ->
			initilizeStub = sinon.stub Backbone.Component.prototype, "initialize"
			@ticker = new Application.Ticker()
			initilizeStub.should.have.been.calledOnce
			initilizeStub.restore()

	describe "Timer Controls", ->
		it "should start a timer if there's none present", ->
			@ticker = new Application.Ticker()
			should.not.exist @ticker.timer

			@ticker.start()
			@ticker.timer.should.exist

		it "should trigger global \"tick\" event on the interval callback", (done) ->
			Backbone.on "tick", ->
				done()
			@ticker.onTick()
			Backbone.off "tick"

		it "should trigger the onTick callback every 50 ms (default)", ->
			onTickSpy = sinon.spy Application.Ticker.prototype, "onTick"
			@ticker.start()
			@clock.tick(50)
			onTickSpy.should.have.been.calledOnce
			onTickSpy.restore()

		it "should stop the timer if there is one present", ->
			should.not.exist @ticker.timer
			@ticker.start()
			@ticker.timer.should.exist
			@ticker.stop()
			should.not.exist @ticker.timer

		it "should change the ticker speed", ->
			@ticker.tick.should.equal 50
			@ticker.changeSpeed 100
			@ticker.tick.should.equal 100

		it "should clear the interval and create a new one when the tick speed changes", ->
			should.not.exist @ticker.timer
			@ticker.start()

			startStub = sinon.stub Application.Ticker.prototype, "start"
			stopStub = sinon.stub Application.Ticker.prototype, "stop"

			@ticker.changeSpeed 100

			startStub.should.have.been.calledOnce
			stopStub.should.have.been.calledOnce

			startStub.restore()
			stopStub.restore()