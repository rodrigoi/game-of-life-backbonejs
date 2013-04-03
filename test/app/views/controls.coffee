chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

Backbone = require "backbone"

Application = require "../../../src/app/views/controls"

testClickEvent = (method, element) ->
	stub = sinon.stub Application.ControlsView.prototype, method

	view = new Application.ControlsView()

	view.setElement "<div><a id=\"#{element}\"></a></div>"
	view.$("##{element}").click()

	stub.should.have.been.calledOnce

	stub.restore()
	return

describe "Controls View", ->

	describe "UI Event Binding", ->
		it "should bind to the click event on the \"start\" element", ->
			testClickEvent "onStart", "start"

		it "should bind to the click event on the \"stop\" element", ->
			testClickEvent "onStop", "stop"

		it "should bind to the click event on the \"next\" element", ->
			testClickEvent "onNext", "next"

		it "should bind to the click event on the \"clear\" element", ->
			testClickEvent "onClear", "clear"

		it "should bind to the click event on the \"save\" element", ->
			testClickEvent "onSave", "save"

		it "should bind to the click event on the \"save\" element", ->
			testClickEvent "onLoad", "load"

		it "should bind to the click event on the \"save\" element", ->
			testClickEvent "onRandomize", "randomize"

		it "should bind to the click event on the \"save\" element", ->
			testClickEvent "onGun", "gun"

	describe "Event Handlers", ->
		beforeEach ->
			@applicationView = new Application.ControlsView()

		it "should disable start, next, clear, save, load, randomize and gun ui elements on start", ->
			@applicationView.setElement "<div><a id=\"start\"></a><a id=\"next\"></a><a id=\"clear\"></a><a id=\"save\"></a><a id=\"load\"></a><a id=\"randomize\"><a id=\"gun\"></a></div>"
			@applicationView.$("a[disabled]").length.should.equal 0
			@applicationView.onStart()
			@applicationView.$("a[disabled]").length.should.equal 7

		it "should enable stop ui element on start", ->
			@applicationView.setElement "<div><a id=\"stop\" disabled></a></div>"
			@applicationView.$("a[disabled]").length.should.equal 1
			@applicationView.onStart()
			@applicationView.$("a[disabled]").length.should.equal 0

		it "should enable start, next, clear, save, load and randomize ui elements on stop", ->
			@applicationView.setElement "<div><a id=\"start\" disabled></a><a id=\"next\" disabled></a><a id=\"clear\" disabled></a><a id=\"save\" disabled></a><a id=\"load\" disabled></a><a id=\"randomize\" disabled><a id=\"gun\" disabled></a></div>"
			@applicationView.$("a[disabled]").length.should.equal 7
			@applicationView.onStop()
			@applicationView.$("a[disabled]").length.should.equal 0

		it "should disable stop ui element on stop handler", ->
			@applicationView.setElement "<div><a id=\"stop\"></a></div>"
			@applicationView.$("a[disabled]").length.should.equal 0
			@applicationView.onStop()
			@applicationView.$("a[disabled]").length.should.equal 1

		describe "Event Broadcasting", ->

			it "should trigger local \"start\" event on the start handler", (done) ->
				@applicationView.on "start", ->
					done()

				@applicationView.onStart()

			it "should trigger local \"stopTimer\" event on the stop handler", (done) ->
				@applicationView.on "stop", ->
					done()

				@applicationView.onStop()
				@applicationView.off "stop"

			it "should trigger the global \"tick\" event on the next handler", (done) ->
				Backbone.on "tick", ->
					done()
				@applicationView.onNext()
				Backbone.off "tick"

			it "should trigger the local \"clear\" event on the clear handler", (done) ->
				@applicationView.on "clear", ->
					done()
				@applicationView.onClear()
				@applicationView.off "clear"

			it "should trigger the local \"save\" event on the save handler", (done) ->
				@applicationView.on "save", ->
					done()

				@applicationView.onSave()
				@applicationView.off "save"

			it "should trigger the local \"load\" event on the load handler", (done) ->
				@applicationView.on "load", ->
					done()

				@applicationView.onLoad()
				@applicationView.off "load"

			it "should trigger the local \"randomize\" event on the randomize handler", (done) ->
				@applicationView.on "randomize", ->
					done()

				@applicationView.onRandomize()
				@applicationView.off "randomize"

			it "should trigger the local \"gun\" event on the gun event handler", (done) ->
				@applicationView.on "gun", ->
					done()

				@applicationView.onGun()
				@applicationView.off "gun"