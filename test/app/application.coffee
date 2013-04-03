chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

Application = require "../../src/app/application"

describe "Application", ->
	it "should exist as a variable for the Namespace", ->
		should.exist Application

	describe "Defaults", ->
		it "should default to a grid of 66 by 20", ->
			Application.width.should.equal 66
			Application.height.should.equal 20

		it "should default with a null ticker", ->
			should.not.exist Application.ticker

		it "should default with a null world view", ->
			should.not.exist Application.worldView

	describe "Initialize", ->
		before ->
			@clock = sinon.useFakeTimers()
			Application.with = 10
			Application.height = 10
			Application.initialize()
		after ->
			@clock.restore()

		it "should initialize the ticker object", ->
			Application.ticker.should.exist

		it "should initialize the storage object", ->
			Application.storage.should.exist

		it "should create an application view"