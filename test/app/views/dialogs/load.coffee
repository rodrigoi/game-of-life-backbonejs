chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

Application = require("../../../../src/app").Application

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

	describe "Render", ->
		it "should return itself to provide a chainable interface", ->
			view = new Application.LoadDialogView
				collection: new Application.Storage()
			view.setElement "<div id=\"#loadDialog\"></div>"
			view.$el.modal = ->
			view.render().should.equal view

		it "should render the items correctly", ->
			view = new Application.LoadDialogView
				storage: new Application.Storage [
					{ name: "foo1", pattern: "bar1" }
					{ name: "foo2", pattern: "bar2" }
				]
			view.setElement "<div id=\"#loadDialog\"><table><tbody></tbody></table></div>"
			view.$el.modal = ->

			view.render()
			view.$("tr").should.have.length 2

	describe "UI Event Handlers", ->
		it "should prevent the default browser behaviour when drag enters", ->
			view = new Application.LoadDialogView()
			eventMock =
				preventDefault: ->
			preventDefaultStub = sinon.stub eventMock, "preventDefault"
			view.onDragEnter eventMock
			preventDefaultStub.restore()
			preventDefaultStub.should.have.been.calledOnce

		it "should prevent the default browser behaviour when drag is over", ->
			view = new Application.LoadDialogView()
			eventMock =
				preventDefault: ->
			preventDefaultStub = sinon.stub eventMock, "preventDefault"
			view.onDragOver eventMock
			preventDefaultStub.restore()
			preventDefaultStub.should.have.been.calledOnce

		it "should prevent the default browser behaviour when drag leaves", ->
			view = new Application.LoadDialogView()
			eventMock =
				preventDefault: ->
			preventDefaultStub = sinon.stub eventMock, "preventDefault"
			view.onDragLeave eventMock
			preventDefaultStub.restore()
			preventDefaultStub.should.have.been.calledOnce

		it "should prevent the default browser behaviour when a file is dropped", ->
			view = new Application.LoadDialogView()
			eventMock =
				preventDefault: ->
				originalEvent:
					dataTransfer:
						files:
							[]

			preventDefaultStub = sinon.stub eventMock, "preventDefault"
			view.onDrop eventMock
			preventDefaultStub.restore()
			preventDefaultStub.should.have.been.calledOnce

		it "should load the text of the input element", ->
			view = new Application.LoadDialogView()
			view.setElement "<div id=\"#loadDialog\"><input type=\"text\" value=\"foo\" /></div>"
			view.$el.modal = ->

			loadFromStringStub = sinon.stub view, "_loadFromString"

			view.onUpload()

			loadFromStringStub.restore()
			loadFromStringStub.should.have.been.calledWith "foo"

	describe "\"private\" methods", ->
		it "should use the world's json update method", ->
			view = new Application.LoadDialogView()
			world = new Application.World()
			updateFromJSONStub = sinon.stub world, "updateFromJSON"

			view.world = world
			view._loadFromString "This should be a JSON string"

			updateFromJSONStub.restore()
			updateFromJSONStub.should.have.been.calledWith "This should be a JSON string"