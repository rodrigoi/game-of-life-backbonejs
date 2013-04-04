(function(){
	"use strict";

	Backbone.Component = function() {
		this.initialize.apply(this, arguments);
	};

	_.extend(Backbone.Component.prototype, {
		initialize : function() {
			return this;
		}
	});

	Backbone.Component.extend = Backbone.View.extend;
})();

if (typeof require === "function" && typeof exports === "object" && typeof module === "object"){
	module.exports = Backbone
}