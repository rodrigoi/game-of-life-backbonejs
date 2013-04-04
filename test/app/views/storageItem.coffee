chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

Application = require("../../../src/app").Application

describe "Storage Item View", ->
	describe "Event UI Binding", ->
		it "should bind itself to the click event of the load button", ->
			onClickStub = sinon.stub Application.StorageItemView.prototype, "onLoad"

			storageItem = new Application.StorageItem
				index: 1, key: "key", value: "value"

			view = new Application.StorageItemView
				model: storageItem

			view.render()
			view.$(".load").click()

			onClickStub.should.have.been.calledOnce
			onClickStub.restore()

		it "should bind itseld to the click event of the remove button", ->
			onClickStub = sinon.stub Application.StorageItemView.prototype, "onRemove"

			storageItem = new Application.StorageItem
				index: 1, key: "key", value: "value"

			view = new Application.StorageItemView
				model: storageItem

			view.render()
			view.$(".remove").click()

			onClickStub.should.have.been.calledOnce
			onClickStub.restore()

	describe "Render", ->
		it "should return itself to provide a chainable interface", ->
			storageItem = new Application.StorageItem
				index: 1, key: "key", value: "value"

			view = new Application.StorageItemView
				model: storageItem

			view.render().should.equal view

		it "should render the storage items", ->
			storageItem = new Application.StorageItem
				index: 1, key: "key", value: "value"

			view = new Application.StorageItemView
				model: storageItem

			view.render()
			view.$el.children().length.should.equal 3

	describe "onLoad method", ->
		it "should trigger view \"loadStorageItem\" event when calling onLoad", (done) ->
			storageItem = new Application.StorageItem
				index: 1, key: "key", value: "value"

			view = new Application.StorageItemView
				model: storageItem

			view.on "loadStorageItem", ->
				done()

			view.onLoad()

	describe "onRemove method", ->
		it "should trigger view \"loadStorageItem\" event when calling onLoad", (done) ->
			storageItem = new Application.StorageItem
				index: 1, key: "key", value: "value"

			view = new Application.StorageItemView
				model: storageItem

			view.on "removeStorageItem", ->
				done()

			view.onRemove()