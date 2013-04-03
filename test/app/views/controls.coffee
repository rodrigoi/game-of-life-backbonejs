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

	describe "Render", ->
		it "should return itself to provide a chainable interface", ->
			view = new Application.ControlsView()
			view.render().should.equal view

	describe "UI Event Handlers", ->
		beforeEach ->
			@view = new Application.ControlsView()

		it "should disable start, next, clear, save, load, randomize and gun ui elements on start", ->
			@view.setElement "<div><a id=\"start\"></a><a id=\"next\"></a><a id=\"clear\"></a><a id=\"save\"></a><a id=\"load\"></a><a id=\"randomize\"><a id=\"gun\"></a></div>"
			@view.$("a[disabled]").length.should.equal 0
			@view.onStart()
			@view.$("a[disabled]").length.should.equal 7

		it "should enable stop ui element on start", ->
			@view.setElement "<div><a id=\"stop\" disabled></a></div>"
			@view.$("a[disabled]").length.should.equal 1
			@view.onStart()
			@view.$("a[disabled]").length.should.equal 0

		it "should enable start, next, clear, save, load and randomize ui elements on stop", ->
			@view.setElement "<div><a id=\"start\" disabled></a><a id=\"next\" disabled></a><a id=\"clear\" disabled></a><a id=\"save\" disabled></a><a id=\"load\" disabled></a><a id=\"randomize\" disabled><a id=\"gun\" disabled></a></div>"
			@view.$("a[disabled]").length.should.equal 7
			@view.onStop()
			@view.$("a[disabled]").length.should.equal 0

		it "should disable stop ui element on stop handler", ->
			@view.setElement "<div><a id=\"stop\"></a></div>"
			@view.$("a[disabled]").length.should.equal 0
			@view.onStop()
			@view.$("a[disabled]").length.should.equal 1

	describe "Event Broadcasting", ->
		it "should trigger local \"start\" event on the start handler", (done) ->
			@view.on "start", ->
				done()

			@view.onStart()

		it "should trigger local \"stopTimer\" event on the stop handler", (done) ->
			@view.on "stop", ->
				done()

			@view.onStop()
			@view.off "stop"

		it "should trigger the global \"tick\" event on the next handler", (done) ->
			Backbone.on "tick", ->
				done()
			@view.onNext()
			Backbone.off "tick"

		it "should trigger the local \"clear\" event on the clear handler", (done) ->
			@view.on "clear", ->
				done()
			@view.onClear()
			@view.off "clear"

		it "should trigger the local \"save\" event on the save handler", (done) ->
			@view.on "save", ->
				done()

			@view.onSave()
			@view.off "save"

		it "should trigger the local \"load\" event on the load handler", (done) ->
			@view.on "load", ->
				done()

			@view.onLoad()
			@view.off "load"

		it "should trigger the local \"randomize\" event on the randomize handler", (done) ->
			@view.on "randomize", ->
				done()

			@view.onRandomize()
			@view.off "randomize"

		it "should trigger the local \"gun\" event on the gun event handler", (done) ->
			@view.on "gun", ->
				done()

			@view.onGun()
			@view.off "gun"