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

		@worldView = new Application.WorldView
			collection: @world

	it "should bind to the tick event", ->
		regenerateSpy = sinon.spy Application.WorldView.prototype, "regenerate"
		@worldView = new Application.WorldView
			collection: @world

		Backbone.trigger "tick"
		Backbone.off "tick" #this is just to improve test performance

		regenerateSpy.should.have.been.calledOnce
		regenerateSpy.restore()

	it "should bind to the clear event", ->
		clearCellsSpy = sinon.spy Application.WorldView.prototype, "clearCells"
		@worldView = new Application.WorldView
			collection: @world

		Backbone.trigger "clear"
		Backbone.off "clear" #test performance trick

		clearCellsSpy.should.have.been.calledOnce
		clearCellsSpy.restore()

	it "should return the view object when calling render", ->
		@worldView.render().should.be.equal @worldView

	it "should render a grid correctly", ->
		@worldView.setElement jQuery("<div></div>")
		@worldView.render()
		@worldView.$el.children().length.should.equal 3

	it "should scan the grid for changes", ->
		shouldBeAliveSpy = sinon.spy Application.Cell.prototype, "shouldBeAlive"

		@worldView.regenerate()
		shouldBeAliveSpy.should.have.been.calledThrice

		shouldBeAliveSpy.restore()

	it "should trigger the regenerate event to notify cells", (done)  ->
		Backbone.on "regenerate", ->
			done()

		@worldView.regenerate()

		Backbone.off "regenerate"

	it "should clear the grid", ->
		world = new Application.World [
			{ x: 0, y: 0, alive: true }
			{ x: 1, y: 0, alive: true }
			{ x: 2, y: 0, alive: false }
		], width: 3, height: 1

		worldView = new Application.WorldView
			collection: world

		worldView.clearCells()

		world.at(0).get("alive").should.not.be.ok
		world.at(1).get("alive").should.not.be.ok
		world.at(2).get("alive").should.not.be.ok