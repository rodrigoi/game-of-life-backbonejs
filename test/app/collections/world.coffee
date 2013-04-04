chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

Application = require("../../../src/app").Application

shouldIgnoreCells = (world, cell, indexes) ->
	world.liveNeighbours(cell).should.equal 0
	for index in indexes
		world.at(index).set "alive", true
		world.liveNeighbours(cell).should.equal 0
	return

shouldCountLivingCells = (world, cell, patterns) ->
	world.liveNeighbours(cell).should.equal 0
	for pattern in patterns
		world.at(pattern[0]).set "alive", true
		world.liveNeighbours(cell).should.equal pattern[1]
	return

describe "World", ->
	describe "Defaults", ->
		it "should default to a 0 by 0 grid if no parameters are provided on the constructor", ->
			world = new Application.World()
			world.width.should.not.be.ok
			world.height.should.not.be.ok
			world.models.should.be.empty

		it "should accept an options argument with width and height", ->
			world = new Application.World null,
				width: 1, height: 1
			world.width.should.equal 1
			world.height.should.equal 1

		it "should initialize to an empty collection with the number of elements specified by width times height", ->
			world = new Application.World null,
				width: 2, height: 2
			world.models.should.have.length 4

	describe "Randomize", ->
		it "should randomize itself", ->
			world = new Application.World null,
				width: 10, height: 10 #large enough sample

			randomStub = sinon.stub Math, "random"
			world.randomize()
			randomStub.restore()
			randomStub.callCount.should.equal 10 * 10

	describe "Clean", ->
		it "should kill all living cells", ->
			world = new Application.World [
				{ x: 0, y: 0, alive: true } #cell at 0
				{ x: 1, y: 0, alive: true } #cell at 1
			], width: 2, height: 1

			world.where(
				alive: true
			).should.have.length 2

			world.clear()

			world.where(
				alive: true
			).should.have.length 0

	describe "Single cell world", ->
		it "should return false for a single cell world", ->
			@world = new Application.World [
				{ x: 0, y: 0 } #cell at 0
			], width: 1, height: 1

			cell = @world.at 0
			@world.liveNeighbours(cell).should.equal 0

	describe "Two cell world", ->
		beforeEach ->
			@world = new Application.World [
				{ x: 0, y: 0 } #cell at 0
				{ x: 1, y: 0 } #cell at 1
			], width: 2, height: 1

		it "should correcly count living neighbours for the left cell", ->
			cell = @world.at 0
			@world.liveNeighbours(cell).should.equal 0

			@world.at(0).set "alive", true
			@world.liveNeighbours(cell).should.equal 0

			@world.at(1).set "alive", true
			@world.liveNeighbours(cell).should.equal 1

		it "should correcly count living neighbours for the right cell", ->
			cell = @world.at 1
			@world.liveNeighbours(cell).should.equal 0

			@world.at(1).set "alive", true
			@world.liveNeighbours(cell).should.equal 0

			@world.at(0).set "alive", true
			@world.liveNeighbours(cell).should.equal 1

	describe "World with a 2 by 2 grid", ->
		beforeEach ->
			@world = new Application.World [
				{ x: 0, y: 0} #cell at 0
				{ x: 1, y: 0} #cell at 1

				{ x: 0, y: 1} #cell at 2
				{ x:1 , y: 1} #cell at 3
			], width: 2, height: 2

		it "should correcly count living neighbours for the top left cell", ->
			cell = @world.at 0
			shouldCountLivingCells @world, cell, [
				[1, 1]
				[2, 2]
				[3, 3]
			]

		it "should correcly count living neighbours for the top right cell", ->
			cell = @world.at 1
			shouldCountLivingCells @world, cell, [
				[0, 1]
				[2, 2]
				[3, 3]
			]

		it "should correcly count living neighbours for the bottom left cell", ->
			cell = @world.at 2
			shouldCountLivingCells @world, cell, [
				[0, 1]
				[1, 2]
				[3, 3]
			]

		it "should correcly count living neighbours for the bottom right cell", ->
			cell = @world.at 3
			shouldCountLivingCells @world, cell, [
				[0, 1]
				[1, 2]
				[2, 3]
			]

	describe "World with a 3 by 3 grid", ->
		beforeEach ->
			@world = new Application.World [
				{ x: 0, y: 0, alive: false } #cell at 0
				{ x: 1, y: 0, alive: false } #cell at 1
				{ x: 2, y: 0, alive: false } #cell at 2

				{ x: 0, y: 1, alive: false } #cell at 3
				{ x: 1, y: 1, alive: false } #cell at 4
				{ x: 2, y: 1, alive: false } #cell at 5

				{ x: 0, y: 2, alive: false } #cell at 6
				{ x: 1, y: 2, alive: false } #cell at 7
				{ x: 2, y: 2, alive: false } #cell at 8
			], width: 3, height: 3

		describe "Neighbours for the center cell", ->

			it "should correcly count living neighbours for the center cell", ->
				cell = @world.at 4
				shouldCountLivingCells @world, cell, [
					[0, 1]
					[1, 2]
					[2, 3]
					[3, 4]
					[5, 5]
					[6, 6]
					[7, 7]
					[8, 8]
				]

		describe "Neighbours for the top left corner", ->
			beforeEach -> @cell = @world.at 0

			it "should correcly count adjacent live cells", ->
				shouldCountLivingCells @world, @cell, [
					[1, 1]
					[3, 2]
					[4, 3]
				]

			it "should ignore not adjacent cells", ->
				shouldIgnoreCells @world, @cell, [2, 5, 6, 7, 8]

		describe "Neighbours for the top center corner", ->
			beforeEach -> @cell = @world.at 1

			it "should correcly count adjacent live cells", ->
				shouldCountLivingCells @world, @cell, [
					[0, 1]
					[2, 2]
					[3, 3]
					[4, 4]
					[5, 5]
				]

			it "should ignore not adjacent cells", ->
				shouldIgnoreCells @world, @cell, [6, 7, 8]

		describe "Neighbours for the top right corner", ->
			beforeEach -> @cell = @world.at 2

			it "should correcly count adjacent live cells", ->
				shouldCountLivingCells @world, @cell, [
					[1, 1]
					[4, 2]
					[5, 3]
				]

			it "should ignore not adjacent cells", ->
				shouldIgnoreCells @world, @cell, [0, 3, 6, 7, 8]

		describe "Neighbours for the center left", ->
			beforeEach -> @cell = @world.at 3

			it "should correcly count adjacent live cells", ->
				shouldCountLivingCells @world, @cell, [
					[0, 1]
					[1, 2]
					[4, 3]
					[6, 4]
					[7, 5]
				]

			it "should ignore not adjacent cells", ->
				shouldIgnoreCells @world, @cell, [2, 5, 8]

		describe "Neighbours for the center right", ->
			beforeEach -> @cell = @world.at 5

			it "should correcly count adjacent live cells", ->
				shouldCountLivingCells @world, @cell, [
					[1, 1]
					[2, 2]
					[4, 3]
					[7, 4]
					[8, 5]
				]

			it "should ignore not adjacent cells", ->
				shouldIgnoreCells @world, @cell, [0, 3, 6]

		describe "Neighbours for the bottom left corner", ->
			beforeEach -> @cell = @world.at 6

			it "should correcly count adjacent live cells", ->
				shouldCountLivingCells @world, @cell, [
					[3, 1]
					[4, 2]
					[7, 3]
				]

			it "should ignore not adjacent cells", ->
				shouldIgnoreCells @world, @cell, [0, 1, 2, 5, 8]

		describe "Neighbours for the bottom center", ->
			beforeEach -> @cell = @world.at 7

			it "should correcly count adjacent live cells", ->
				shouldCountLivingCells @world, @cell, [
					[3, 1]
					[4, 2]
					[5, 3]
					[6, 4]
					[8, 5]
				]

			it "should ignore not adjacent cells", ->
				shouldIgnoreCells @world, @cell, [0, 1, 2]

		describe "Neighbours for the bottom right corner", ->
			beforeEach -> @cell = @world.at 8

			it "should correcly count adjacent live cells", ->
				shouldCountLivingCells @world, @cell, [
					[4, 1]
					[5, 2]
					[7, 3]
				]

			it "should ignore not adjacent cells", ->
				shouldIgnoreCells @world, @cell, [0, 1, 2, 3, 6]