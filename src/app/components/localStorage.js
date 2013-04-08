var Application = Application || {};

if (typeof require === "function" && typeof exports === "object" && typeof module === "object"){
	module.exports = Application
	Application = global.Application

	var localStorage = null;
}

(function(){
	"use strict";

	Application.LocalStorage = Backbone.Component.extend({
		items: null,
		initialize: function(options){
			options || (options = {});
			if (options.localStorage) localStorage = options.localStorage

			Backbone.Component.prototype.initialize.apply(this, arguments);

			this.items = new Application.Storage();
			this.items.fetch();
		}
	});
})();