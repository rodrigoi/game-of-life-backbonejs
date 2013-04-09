var Application = Application || {};

if (typeof require === "function" && typeof exports === "object" && typeof module === "object"){
	module.exports = Application;
	Application = global.Application;
	Backbone = global.Backbone;
	Application.StorageItem = Backbone.Model.extend({});
}

(function(){
	"use strict";

	Application.Storage = Backbone.Collection.extend({
		model: Application.StorageItem,
		localStorage: new Backbone.LocalStorage("LifePatterns")
	});
})();