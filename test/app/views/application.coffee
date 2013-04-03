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

	describe "UI Event Binding", ->
		it "should bind to the submit event on the \"setTick\" element", ->
			spy = sinon.spy Application.AppView.prototype, "onSetTickFromSubmit"

			view = new Application.AppView()
			view.setElement "<div><form id=\"setTickForm\"></form></div>"
			view.$("#setTickForm").submit()

			spy.should.have.been.calledOnce

			spy.restore()

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

	describe "other UI Events", ->
		it "should trigger the local \"changeSpeed\" event on the form submit event handler with the new speed", (done) ->
			@applicationView.setElement "<div><form id=\"setTickForm\"><input id=\"tick\" type=\"text\" value=\"500\"/></form></div>"

			@applicationView.on "changeSpeed", (newSpeed) ->
				newSpeed.should.equal "500"
				done()

			@applicationView.onSetTickFromSubmit()
			@applicationView.off "changeSpeed"

		it "should cancel the form submit on the form submit event handler", ->
			@applicationView.onSetTickFromSubmit().should.not.be.ok

		#it "should trigger the local \"save\" event on save handler", (done) ->
		#	@applicationView.on "save", ->
		#		done()

		#	@applicationView.onSave()
		#	@applicationView.off "save"

		#it "should trigger the local \"load\" event on load handler", (done) ->
		#	@applicationView.on "load", ->
		#		done()

		#	@applicationView.onLoad()
		#	@applicationView.off "load"

		#it "should trigger the local \"randomize\" event on randomize handler", (done) ->
		#	@applicationView.on "randomize", ->
		#		done()

		#	@applicationView.onRandomize()
		#	@applicationView.off "randomize"