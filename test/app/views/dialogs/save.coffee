chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

Application = require "../../../../src/app/views/dialogs/save"

testClickEvent = (method, element) ->
	stub = sinon.stub Application.SaveDialogView.prototype, method
	view = new Application.SaveDialogView()
	view.setElement "<div><a id=\"#{element}\"></a></div>"
	view.$("##{element}").click()
	stub.should.have.been.calledOnce
	stub.restore()
	return

describe "Save Dialog View", ->
	describe "Defauls", ->
		it "should default with an empty json string", ->
			view = new Application.SaveDialogView()
			view.json.should.not.be.ok

	describe "UI Event Binding", ->
		it "should bind to the click event on the \"download\" element", ->
			testClickEvent "onDownload", "download"

		it "should bind to the click event on the \"saveToLocalStorage\" element", ->
			testClickEvent "onSaveToLocalStorage", "saveToLocalStorage"

	describe "Render", ->
		it "should return itself to provide a chainable interface", ->
			view = new Application.SaveDialogView()
			view.storage = new Application.LocalStorage()

			modalStub = sinon.stub()
			view.$el.modal = modalStub

			view.render().should.equal view

			modalStub.should.have.been.calledWithExactly "show"

	describe "onSaveToLocalStorage method", ->
		it "should save the grid to local storage", ->
			view = new Application.SaveDialogView()
			storage = new Application.LocalStorage()

			view.json = "json here"

			storageMock = sinon.mock storage
			storageMock.expects("addByJson").once().withExactArgs "pattern name", view.json

			view.storage = storage

			view.setElement "<div id=\"#saveDialog\"><form id=\"setTickForm\"><input id=\"patternName\" type=\"text\" value=\"pattern name\"/></form></div>"

			modalStub = sinon.stub()
			view.$el.modal = modalStub

			view.onSaveToLocalStorage()

			modalStub.should.have.been.calledWithExactly "hide"
			storageMock.verify()