var Application = Application || {};

if (typeof module !== "undefined" && module.exports) {
	var Backbone = Backbone || require("backbone");

	module.exports = Application;
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