chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

Backbone = require "backbone"
jQuery = require "jquery"

Application = require "../../../src/app/views/world"

describe "World View", ->
	beforeEach ->
		@world = new Application.World [
			{ x: 0, y: 0 } #cell at 0
			{ x: 1, y: 0 } #cell at 1
			{ x: 2, y: 0 } #cell at 2
		], width: 3, height: 1

		@view = new Application.WorldView
			collection: @world

	describe "Initialize", ->
		it "should bind to the tick event", ->
			regenerateSpy = sinon.spy Application.WorldView.prototype, "regenerate"
			@view = new Application.WorldView
				collection: @world

			Backbone.trigger "tick"

			regenerateSpy.should.have.been.calledOnce
			regenerateSpy.restore()

	describe "Render", ->
		it "should return itself to provide a chainable interface", ->
			@view.render().should.be.equal @view

		it "should render a grid correctly", ->
			@view.setElement jQuery("<div></div>")
			@view.render()
			@view.$el.children().length.should.equal 3

	describe "Regenerate method", ->
		it "should scan the grid for changes", ->
			shouldBeAliveSpy = sinon.spy Application.Cell.prototype, "shouldBeAlive"

			@view.regenerate()
			shouldBeAliveSpy.should.have.been.calledThrice

			shouldBeAliveSpy.restore()

		it "should trigger the \"regenerate\" global event to notify cells", (done)  ->
			Backbone.on "regenerate", ->
				done()

			@view.regenerate()

	describe "Clear method", ->
		it "should call the collection's \"clear\" method", ->
			clearStub = sinon.stub Application.World.prototype, "clear"
			@view.clear()
			clearStub.should.have.been.calledOnce
			clearStub.restore()

	describe "Randomize method", ->
		it "should call the collection's \"randomize\" method", ->
			randomizeStub = sinon.stub Application.World.prototype, "randomize"
			@view.randomize()
			randomizeStub.should.have.been.calledOnce
			randomizeStub.restore()