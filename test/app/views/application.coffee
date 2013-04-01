chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

Backbone = require "backbone"
Backbone.$ = require "jquery"

Application = require "../../../src/app/views/application"

testClickEvent = (method, element) ->
	spy = sinon.spy Application.AppView.prototype, method

	view = new Application.AppView()
	view.setElement "<div><a id=\"#{element}\"></a></div>"
	view.$("##{element}").click()

	spy.should.have.been.calledOnce

	spy.restore()
	return

describe "Application View", ->
	before ->
		@clock = sinon.useFakeTimers()

	after ->
		@clock.restore()

	beforeEach ->
		@applicationView = new Application.AppView()

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

	describe "Initialize", ->
		it "should bind to the global \"regenerate\" event", ->
			renderSpy = sinon.spy Application.AppView.prototype, "render"
			@applicationView = new Application.AppView()
			Backbone.trigger "regenerate"
			Backbone.off "regenerate"

			renderSpy.should.have.been.calledOnce
			renderSpy.restore()

		it "should bind to the global \"tick\" event", ->
			renderSpy = sinon.spy Application.AppView.prototype, "onTick"
			@applicationView = new Application.AppView()
			Backbone.trigger "tick"
			Backbone.off "tick"

			renderSpy.should.have.been.calledOnce
			renderSpy.restore()

	describe "Render", ->
		it "should render the generation counter", ->
			@applicationView.generation = 100
			@applicationView.setElement "<div><span id=\"generationCount\"></span></div>"
			@applicationView.render()
			@applicationView.$("#generationCount").text().should.equal "100"

		it "should increment the generation counter on tick", ->
			@applicationView.generation.should.equal 0
			@applicationView.onTick()
			@applicationView.generation.should.equal 1

		it "should render itself on tick", ->
			renderSpy = sinon.spy @applicationView, "render"
			@applicationView.onTick()
			renderSpy.should.have.been.calledOnce

			renderSpy.restore()

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

		it "should trigger global \"startTimer\" event on start", (done) ->
			Backbone.on "startTimer", ->
				done()

			@applicationView.onStart()
			Backbone.off "startTimer"

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

		it "should trigger global \"stopTimer\" event on stop handler", (done) ->
			Backbone.on "stopTimer", ->
				done()

			@applicationView.onStop()
			Backbone.off "stopTimer"

	describe "other UI Events", ->
		it "should trigger the global \"tick\" event on the next handler", (done) ->
			Backbone.on "tick", ->
				done()
			@applicationView.onNext()
			Backbone.off "tick"

		describe "Clear", ->
			it "should reset the generation counter to zero", ->
				@applicationView.generation = 1
				@applicationView.onClear()
				@applicationView.generation.should.equal 0

			it "should render the application view", ->
				renderSpy = sinon.spy Application.AppView.prototype, "render"
				@applicationView.onClear()
				renderSpy.should.have.been.calledOnce
				renderSpy.restore()

			it "should trigger the global \"clear\" event", (done) ->
				Backbone.on "clear", ->
					done()
				@applicationView.onClear()
				Backbone.off "clear"

		it "should trigger the global \"changeSpeed\" event on the form submit event handler with the new speed", (done) ->
			@applicationView.setElement "<div><form id=\"setTickForm\"><input id=\"tick\" type=\"text\" value=\"500\"/></form></div>"

			Backbone.on "changeSpeed", (newSpeed) ->
				newSpeed.should.equal "500"
				done()

			@applicationView.onSetTickFromSubmit()
			Backbone.off "changeSpeed"

		it "should cancel the form submit on the form submit event handler", ->
			@applicationView.onSetTickFromSubmit().should.not.be.ok

		it "should trigger the global \"save\" event on save handler", (done) ->
			Backbone.on "save", ->
				done()

			@applicationView.onSave()
			Backbone.off "save"

		it "should trigger the global \"load\" event on load handler", (done) ->
			Backbone.on "load", ->
				done()

			@applicationView.onLoad()
			Backbone.off "load"

		it "should trigger the global \"randomize\" event on randomize handler", (done) ->
			Backbone.on "randomize", ->
				done()

			@applicationView.onRandomize()
			Backbone.off "randomize"