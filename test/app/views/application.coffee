chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

Backbone = require "backbone"
_ = require "underscore"

Application = require "../../../src/app/views/application"

testClickEvent = (method, element) ->
	stub = sinon.stub Application.AppView.prototype, method

	view = new Application.AppView()
	removeListeners view

	view.setElement "<div><a id=\"#{element}\"></a></div>"
	view.$("##{element}").click()

	stub.should.have.been.calledOnce

	stub.restore()
	return

removeListeners = (view) ->
	_.each view.children, (children) ->
		children.stopListening view
		return

	_.each view.dialogs, (children) ->
		children.stopListening view
		return

	return

describe "Application View", ->
	before ->
		@clock = sinon.useFakeTimers()

	after ->
		@clock.restore()

	beforeEach ->
		@applicationView = new Application.AppView()
		removeListeners @applicationView

	describe "Event Handlers", ->
		it "should bind to the click event on the \"start\" element", ->
			testClickEvent "onStart", "start"

		it "should bind to the click event on the \"stop\" element", ->
			testClickEvent "onStop", "stop"

		it "should bind to the click event on the \"next\" element", ->
			testClickEvent "onNext", "next"

		it "should bind to the click event on the \"clear\" element", ->
			testClickEvent "onClear", "clear"

		it "should bind to the submit event on the \"setTick\" element", ->
			spy = sinon.spy Application.AppView.prototype, "onSetTickFromSubmit"

			view = new Application.AppView()
			view.setElement "<div><form id=\"setTickForm\"></form></div>"
			view.$("#setTickForm").submit()

			spy.should.have.been.calledOnce

			spy.restore()

		it "should bind to the click event on the \"save\" element", ->
			testClickEvent "onSave", "save"

		it "should bind to the click event on the \"load\" element", ->
			testClickEvent "onLoad", "load"

		it "should bind to the click event on the \"randomize\" element", ->
			testClickEvent "onRandomize", "randomize"

		it "should bind to the click event on the \"load gun\" element", ->
			testClickEvent "onGun", "gun"

	describe "Initialize", ->
		it "should call the initialize children method", ->
			stub = sinon.stub Application.AppView.prototype, "initializeChildren"
			@applicationView = new Application.AppView()
			stub.should.have.been.calledOnce
			stub.restore()

		it "should call the initialize dialogs method", ->
			stub = sinon.stub Application.AppView.prototype, "initializeDialogs"
			@applicationView = new Application.AppView()
			stub.should.have.been.calledOnce
			stub.restore()

	describe "Render", ->
		it "should return itself to provide a chainable interface"

	describe "Start", ->
		it "should disable start, next, clear, save, load and randomize ui elements on start", ->
			@applicationView.setElement "<div><a id=\"start\"></a><a id=\"next\"></a><a id=\"clear\"></a><a id=\"save\"></a><a id=\"load\"></a><a id=\"randomize\"></a></div>"
			@applicationView.$("a[disabled]").length.should.equal 0
			@applicationView.onStart()
			@applicationView.$("a[disabled]").length.should.equal 6

		it "should enable stop ui element on start", ->
			@applicationView.setElement "<div><a id=\"stop\" disabled></a></div>"
			@applicationView.$("a[disabled]").length.should.equal 1
			@applicationView.onStart()
			@applicationView.$("a[disabled]").length.should.equal 0

		it "should trigger local \"start\" event on start", (done) ->
			@applicationView.on "start", ->
				done()

			@applicationView.onStart()

	describe "Stop", ->
		it "should enable start, next, clear, save, load and randomize ui elements on stop", ->
			@applicationView.setElement "<div><a id=\"start\" disabled></a><a id=\"next\" disabled></a><a id=\"clear\" disabled></a><a id=\"save\" disabled></a><a id=\"load\" disabled></a><a id=\"randomize\" disabled></a></div>"
			@applicationView.$("a[disabled]").length.should.equal 6
			@applicationView.onStop()
			@applicationView.$("a[disabled]").length.should.equal 0

		it "should disable stop ui element on stop handler", ->
			@applicationView.setElement "<div><a id=\"stop\"></a></div>"
			@applicationView.$("a[disabled]").length.should.equal 0
			@applicationView.onStop()
			@applicationView.$("a[disabled]").length.should.equal 1

		it "should trigger local \"stopTimer\" event on stop handler", (done) ->
			@applicationView.on "stop", ->
				done()

			@applicationView.onStop()
			@applicationView.off "stop"

	describe "other UI Events", ->
		it "should trigger the local \"tick\" event on the next handler", (done) ->
			Backbone.on "tick", ->
				done()
			@applicationView.onNext()
			Backbone.off "tick"

		describe "Clear", ->
			it "should trigger the local \"clear\" event", (done) ->
				@applicationView.on "clear", ->
					done()
				@applicationView.onClear()
				@applicationView.off "clear"

		it "should trigger the local \"changeSpeed\" event on the form submit event handler with the new speed", (done) ->
			@applicationView.setElement "<div><form id=\"setTickForm\"><input id=\"tick\" type=\"text\" value=\"500\"/></form></div>"

			@applicationView.on "changeSpeed", (newSpeed) ->
				newSpeed.should.equal "500"
				done()

			@applicationView.onSetTickFromSubmit()
			@applicationView.off "changeSpeed"

		it "should cancel the form submit on the form submit event handler", ->
			@applicationView.onSetTickFromSubmit().should.not.be.ok

		it "should trigger the local \"save\" event on save handler", (done) ->
			@applicationView.on "save", ->
				done()

			@applicationView.onSave()
			@applicationView.off "save"

		it "should trigger the local \"load\" event on load handler", (done) ->
			@applicationView.on "load", ->
				done()

			@applicationView.onLoad()
			@applicationView.off "load"

		it "should trigger the local \"randomize\" event on randomize handler", (done) ->
			@applicationView.on "randomize", ->
				done()

			@applicationView.onRandomize()
			@applicationView.off "randomize"