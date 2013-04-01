chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

Application = require "../../../src/app/views/cell"

describe "Cell View", ->
	beforeEach ->
		@cellView = new Application.CellView
			model: new Application.Cell()

	it "should respond to the click event", ->
		cell = new Application.Cell
			alive: false

		onClickSpy = sinon.spy Application.CellView.prototype, "onClick"
		@cellView = new Application.CellView
			model: cell

		@cellView.render()
		@cellView.$el.click()

		onClickSpy.should.have.been.calledOnce
		onClickSpy.restore()

	it "should bind itself to the model's change event for the alive property only", ->
		cell = new Application.Cell
			alive: false

		renderSpy = sinon.spy Application.CellView.prototype, "render"
		@cellView = new Application.CellView
			model: cell

		cell.set "nextState", true
		renderSpy.should.not.have.been.called

		cell.set "alive", true
		renderSpy.should.have.been.calledOnce

		renderSpy.restore()

	it "should return the view object when calling render", ->
		@cellView.render().should.equal @cellView

	it "should render a div with a class for a live cell", ->
		cell = new Application.Cell
			alive: true

		@cellView.model = cell

		@cellView.render()
		@cellView.$el.hasClass("alive").should.be.ok

	it "should render a div without class for a dead cell", ->
		cell = new Application.Cell
			alive: false

		@cellView.model = cell

		@cellView.render()
		@cellView.$el.hasClass("alive").should.not.be.ok

	it "should toggle the model's state when the onClick event handler is called", ->
		cell = new Application.Cell
			alive: false
		@cellView.model = cell
		@cellView.onClick()
		cell.get("alive").should.be.ok