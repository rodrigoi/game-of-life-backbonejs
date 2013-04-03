chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

Application = require "../../../../src/app/views/dialogs/save"

describe "Save Dialog View", ->
	describe "Defauls", ->
	describe "UI Event Binding", ->
	describe "Render", ->
		it "should return itself to provide a chainable interface", ->
			view = new Application.SaveDialogView()
			view.render().should.equal view

	describe "onDownload method", ->
	describe "onSaveToLocalStorage method", ->