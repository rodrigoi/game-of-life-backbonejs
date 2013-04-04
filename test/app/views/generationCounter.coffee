chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

Application = require("../../../src/app").Application

describe "Generation Counter View", ->
	beforeEach ->
		@view = new Application.GenerationCounterView()
		@view.setElement "<span id=\"generationCounter\"></span>"

	describe "Initialize", ->
		it "should initialize the generations counter to zero", ->
			@view.generations.should.not.be.ok

		it "should bind to the global \"tick\" event", ->
			onTickStub = sinon.stub Application.GenerationCounterView.prototype, "onTick"
			@view = new Application.GenerationCounterView()
			Backbone.trigger "tick"
			onTickStub.should.have.been.calledOnce
			onTickStub.restore()

	describe "Render", ->
		it "should return itself to provide a chainable interface", ->
			@view.render().should.equal @view

		it "should render the 0", ->
			@view.render()
			@view.$el.html().should.equal "0"

		it "should update the generation counter UI", ->
			@view.generations = 100
			@view.render()
			@view.$el.html().should.equal "100"

	describe "onTick method", ->
		it "should increment the generations counter", ->
			@view.generations.should.not.be.ok
			@view.onTick()
			@view.generations.should.equal 1

		it "should call the render method", ->
			renderStub = sinon.stub Application.GenerationCounterView.prototype, "render"
			@view.onTick()
			renderStub.should.have.been.calledOnce
			renderStub.restore()

	describe "clear method", ->
		it "should set the generations counter to zero", ->
			@view.generations = 100
			@view.clear()
			@view.generations.should.equal 0

		it "should call the render method", ->
			renderStub = sinon.stub Application.GenerationCounterView.prototype, "render"
			@view.clear()
			renderStub.should.have.been.calledOnce
			renderStub.restore()