chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

LocalStorage = require('node-localstorage').LocalStorage;

Backbone = require("../../../src/app").Backbone
Application = require("../../../src/app").Application

localStorage = new LocalStorage "./scratch"

jsonData = "{\"world\":[{\"x\":0,\"y\":0}],\"width\":2,\"height\":1,\"type\":\"world\"}"

describe "Local Storage Component", ->
	before ->
		localStorage.clear()
	beforeEach ->
		localStorage.clear()
		@storage = new Application.LocalStorage()

	it "should call the base class initialize method", ->
		initilizeStub = sinon.stub Backbone.Component.prototype, "initialize"
		storage = new Application.LocalStorage()
		initilizeStub.should.have.been.calledOnce
		initilizeStub.restore()

	it "should initialize with an empty items list", ->
		@storage.storageItems().length.should.equal 0

	it "should return the items list", ->
		@storage.storageItems().should.equal @storage.items

	it "should add an element to the local storage object using a json string", ->
		name = "this is the name"
		localStorageMock = sinon.mock localStorage
		localStorageMock.expects("setItem").once

		@storage = new Application.LocalStorage
			localStorage: localStorage

		@storage.storageItems().length.should.equal 0
		@storage.addByJson name, jsonData

		@storage.storageItems().length.should.equal 1

		localStorageMock.verify()

	it "should add an element to the local storage object using a world collection", ->
		name = "this is the name"
		world = new Application.World [
			{ x: 0, y: 0, alive: true } #cell at 0
			{ x: 1, y: 0 } #cell at 1
		], width: 2, height: 1

		localStorageMock = sinon.mock localStorage
		localStorageMock.expects("setItem").once().withExactArgs name, jsonData

		@storage = new Application.LocalStorage
			localStorage: localStorage
		@storage.storageItems().length.should.equal 0

		@storage.addByWorld name, world

		@storage.storageItems().length.should.equal 1

		localStorageMock.verify()

	it "should remove an storage item from the local storage and the items collection", ->
		localStorageMock = sinon.mock localStorage
		localStorageMock.expects("removeItem").once().withExactArgs "this is the name"

		removeItemStub = sinon.stub Application.Storage.prototype, "remove"

		@storage = new Application.LocalStorage
			localStorage: localStorage
		@storage.storageItems().length.should.equal 0

		@storage.addByJson "this is the name", jsonData

		@storage.remove new Application.StorageItem
			index: 1, key: "this is the name", value: jsonData

		removeItemStub.restore()
		removeItemStub.should.have.been.calledOnce
		localStorageMock.verify()

	it "should create a json representation of the living cells", ->
		world = new Application.World [
			{ x: 0, y: 0, alive: true } #cell at 0
			{ x: 1, y: 0 } #cell at 1
		], width: 2, height: 1

		@storage.createJSONItem(world).should.equal jsonData

	it "should update a given world with from saved json string data", ->
		world = new Application.World [
			{ x: 0, y: 0 } #cell at 0
			{ x: 1, y: 0 } #cell at 1
		], width: 2, height: 1

		@storage.updateWorldFromJSON world, jsonData

		world.at(0).get("alive").should.be.ok
		world.at(1).get("alive").should.not.be.ok

	it "should update a given world with from saved object data", ->
		world = new Application.World [
			{ x: 0, y: 0 } #cell at 0
			{ x: 1, y: 0 } #cell at 1
		], width: 2, height: 1

		@storage.updateWorldFromSavedData world,
			world: [
				{ x: 0, y: 0}
			], width: 2, height: 1, type: "world"

		world.at(0).get("alive").should.be.ok
		world.at(1).get("alive").should.not.be.ok