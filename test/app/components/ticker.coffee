chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

Backbone = require "../../../src/app/base/component"
Application = require "../../../src/app/components/ticker"

Application.use Backbone

testEventBinding = (callbackName, eventName) =>
	spy = sinon.spy Application.Ticker.prototype, callbackName
	ticker = new Application.Ticker()

	Backbone.trigger eventName
	Backbone.off eventName

	spy.should.have.been.calledOnce
	spy.restore()
	return

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
			initilizeSpy = sinon.spy Backbone.Component.prototype, "initialize"
			@ticker = new Application.Ticker()
			initilizeSpy.should.have.been.calledOnce
			initilizeSpy.restore()

		it "should bind to the global \"startTimer\" event", ->
			testEventBinding "onStartTimer", "startTimer"

		it "should bind to the global \"stopTimer\" event", ->
			testEventBinding "onStopTimer", "stopTimer"

		it "should bind to the global \"changeSpeed\" event", ->
			testEventBinding "onChangeSpeed", "changeSpeed"

	describe "Timer Controls", ->

		it "should start a timer if there's none present", ->
			@ticker = new Application.Ticker()
			should.not.exist @ticker.timer

			@ticker.onStartTimer()
			@ticker.timer.should.exist

		it "should trigger global \"tick\" event on the interval callback", (done) ->
			Backbone.on "tick", ->
				done()
			@ticker.onTick()
			Backbone.off "tick"

		it "should trigger the onTick callback every 50 ms (default)", ->
			onTickSpy = sinon.spy Application.Ticker.prototype, "onTick"
			@ticker.onStartTimer()
			@clock.tick(50)
			onTickSpy.should.have.been.calledOnce
			onTickSpy.restore()

		it "should stop the timer if there is one present", ->
			should.not.exist @ticker.timer
			@ticker.onStartTimer()
			@ticker.timer.should.exist
			@ticker.onStopTimer()
			should.not.exist @ticker.timer

		it "should change the ticker speed", ->
			@ticker.tick.should.equal 50
			@ticker.onChangeSpeed 100
			@ticker.tick.should.equal 100

		it "should clear the interval and create a new one when the tick speed changes", ->
			should.not.exist @ticker.timer
			@ticker.onStartTimer()

			onStartTimerSpy = sinon.spy Application.Ticker.prototype, "onStartTimer"
			onStopTimerSpy = sinon.spy Application.Ticker.prototype, "onStopTimer"

			@ticker.onChangeSpeed 100

			onStartTimerSpy.should.have.been.calledOnce
			onStopTimerSpy.should.have.been.calledOnce

			onStartTimerSpy.restore()
			onStopTimerSpy.restore()