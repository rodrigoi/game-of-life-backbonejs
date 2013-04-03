chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

Application = require "../../../src/app/views/cell"

describe "Cell View", ->
	beforeEach ->
		@view = new Application.CellView
			model: new Application.Cell()

	it "should respond to the click event", ->
		cell = new Application.Cell
			alive: false

		onClickStub = sinon.stub Application.CellView.prototype, "onClick"
		@view = new Application.CellView
			model: cell

		@view.render()
		@view.$el.click()

		onClickStub.should.have.been.calledOnce
		onClickStub.restore()

	it "should bind itself to the model's change event for the alive property only", ->
		cell = new Application.Cell
			alive: false

		renderSpy = sinon.spy Application.CellView.prototype, "render"
		@view = new Application.CellView
			model: cell

		cell.set "nextState", true
		renderSpy.should.not.have.been.called

		cell.set "alive", true
		renderSpy.should.have.been.calledOnce

		renderSpy.restore()

	it "should return the view object when calling render", ->
		@view.render().should.equal @view

	it "should render a div with a class for a live cell", ->
		cell = new Application.Cell
			alive: true

		@view.model = cell

		@view.render()
		@view.$el.hasClass("alive").should.be.ok

	it "should render a div without class for a dead cell", ->
		cell = new Application.Cell
			alive: false

		@view.model = cell

		@view.render()
		@view.$el.hasClass("alive").should.not.be.ok

	it "should toggle the model's state when the onClick event handler is called", ->
		cell = new Application.Cell
			alive: false
		@view.model = cell
		@view.onClick()
		cell.get("alive").should.be.ok