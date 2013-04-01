var Application = Application || {};

if (typeof module !== "undefined" && module.exports) {
	var jQuery = $ = jQuery || require("jquery");
	var _ = _ || require("underscore");
	var Backbone = Backbone || require("backbone");
	Backbone.$ = jQuery;

	Application = require("../models/cell");

	module.exports = Application;
}

(function(){
	"use strict";

	Application.CellView = Backbone.View.extend({
		events: {
			"click": "onClick"
		},
		initialize: function(){
			this.model.on("change:alive", this.render, this);
		},
		render: function(){
			(this.model.get("alive")) ? this.$el.addClass("alive") : this.$el.removeClass("alive");
			return this;
		},
		onClick: function(){
			this.model.toggleState();
		}
	});

})();