chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

Application = require "../../../src/app/views/storageItem"

describe "Storage Item View", ->

	it "should bind itself to the click event of the load button", ->
		onClickSpy = sinon.spy Application.StorageItemView.prototype, "onLoad"

		storageItem = new Application.StorageItem
			index: 1, key: "key", value: "value"

		view = new Application.StorageItemView
			model: storageItem

		view.render()
		view.$(".load").click()

		onClickSpy.should.have.been.calledOnce
		onClickSpy.restore()

	it "should bind itseld to the click event of the remove button", ->
		onClickSpy = sinon.spy Application.StorageItemView.prototype, "onRemove"

		storageItem = new Application.StorageItem
			index: 1, key: "key", value: "value"

		view = new Application.StorageItemView
			model: storageItem

		view.render()
		view.$(".remove").click()

		onClickSpy.should.have.been.calledOnce
		onClickSpy.restore()

	it "should render itself", ->
		storageItem = new Application.StorageItem
			index: 1, key: "key", value: "value"

		view = new Application.StorageItemView
			model: storageItem

		view.render()
		view.$el.children().length.should.equal 3

	it "should trigger view \"loadStorageItem\" event when calling onLoad", (done) ->
		storageItem = new Application.StorageItem
			index: 1, key: "key", value: "value"

		view = new Application.StorageItemView
			model: storageItem

		view.on "loadStorageItem", ->
			done()

		view.onLoad()

	it "should trigger view \"loadStorageItem\" event when calling onLoad", (done) ->
		storageItem = new Application.StorageItem
			index: 1, key: "key", value: "value"

		view = new Application.StorageItemView
			model: storageItem

		view.on "removeStorageItem", ->
			done()

		view.onRemove()