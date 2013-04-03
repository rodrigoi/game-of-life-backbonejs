chai = require "chai"
sinon = require "sinon"

should = chai.should()
chai.use require("sinon-chai")

Backbone = require "../../../src/app/base/component"
Application = require "../../../src/app/components/localStorage"

describe "Local Storage Component", ->
	it "should call the base class initialize method"
	it "should initialize with an empty items list"