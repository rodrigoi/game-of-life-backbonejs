var Application = Application || {};

if (typeof require === "function" && typeof exports === "object" && typeof module === "object"){
	module.exports = Application
	Application = global.Application
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