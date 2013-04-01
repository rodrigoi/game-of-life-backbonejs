if (typeof module !== "undefined" && module.exports) {
	var _ = _ || require("underscore");
	var Backbone = Backbone || require("backbone");

	module.exports = Backbone
}

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