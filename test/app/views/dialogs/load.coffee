chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

Application = require "../../../../src/app/views/dialogs/load"

testCustomUIEvent = (method, element, event) ->
	stub = sinon.stub Application.LoadDialogView.prototype, method
	view = new Application.LoadDialogView()
	view.setElement "<div id=\"#loadDialog\"><div class=\"#{element}\"></div></div>"
	view.$(".#{element}").trigger event
	stub.should.have.been.calledOnce
	stub.restore()

testClickEvent = (method, element) ->
	stub = sinon.stub Application.LoadDialogView.prototype, method
	view = new Application.LoadDialogView()
	view.setElement "<div><a id=\"#{element}\"></a></div>"
	view.$("##{element}").click()
	stub.should.have.been.calledOnce
	stub.restore()
	return

describe "Load Dialog View", ->
	describe "UI Event Binding", ->
		it "should bind to the dragenter event on the \"well\" element", ->
			testCustomUIEvent "onDragEnter", "well", "dragenter"

		it "should bind to the dragover event on the \"well\" element", ->
			testCustomUIEvent "onDragOver", "well", "dragover"

		it "should bind to the dragleave event on the \"well\" element", ->
			testCustomUIEvent "onDragLeave", "well", "dragleave"

		it "should bind to the drop event on the \"well\" element", ->
			testCustomUIEvent "onDrop", "well", "drop"

		it "should bind to the click event on the \"upload\" element", ->
			testClickEvent "onUpload", "upload"