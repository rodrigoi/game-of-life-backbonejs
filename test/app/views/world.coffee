chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

jQuery = require("../../../src/app").jQuery
Backbone = require("../../../src/app").Backbone
Application = require("../../../src/app").Application

describe "World View", ->
	beforeEach ->
		@world = new Application.World null,
			width: 3, height: 1

		@view = new Application.WorldView
			collection: @world

	describe "Initialize", ->
		it "should bind to the global tick event", ->
			regenerateStub = sinon.stub Application.WorldView.prototype, "regenerate"
			@view = new Application.WorldView
				collection: @world

			Backbone.trigger "tick"
			regenerateStub.restore()
			regenerateStub.should.have.been.calledOnce

	describe "Render", ->
		it "should return itself to provide a chainable interface", ->
			@view.render().should.be.equal @view

		it "should render a grid correctly", ->
			@view.setElement "<div class=\".world\"></div>"
			@view.render()
			@view.$el.children().length.should.equal 3

	describe "Regenerate method", ->
		it "should scan the grid for changes", ->
			shouldBeAliveStub = sinon.stub Application.Cell.prototype, "shouldBeAlive"

			@view.regenerate()
			shouldBeAliveStub.restore()
			shouldBeAliveStub.should.have.been.calledThriceß

		it "should trigger the \"regenerate\" global event to notify cells", (done)  ->
			test = () ->
				Backbone.off "regenerate", test
				done()
			Backbone.on "regenerate", test
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