var Application = Application || {};

if (typeof module !== "undefined" && module.exports) {
	var _ = _ || require("underscore");
	var Backbone = Backbone || require("backbone");

	module.exports = Application;
}

(function(){
	"use strict";

	Application.Storage = Backbone.Collection.extend({
		model: Application.StorageItem
	});
})();