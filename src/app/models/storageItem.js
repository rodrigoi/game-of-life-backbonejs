var Application = Application || {};

if (typeof require === "function" && typeof exports === "object" && typeof module === "object"){
	module.exports = Application
	Application = global.Application
}

(function(){
	"use strict";

	Application.StorageItem = Backbone.Model.extend({
		defaults: {
			index: 0,
			key: "",
			value: ""
		}
	});
})();