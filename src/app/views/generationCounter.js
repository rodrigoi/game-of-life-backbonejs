var Application = Application || {};

if (typeof require === "function" && typeof exports === "object" && typeof module === "object"){
	module.exports = Application
	Application = global.Application
}

(function(){
	"use strict";

	Application.GenerationCounterView = Backbone.View.extend({
		el: "#generationCounter",
		generations: null,
		initialize: function(){
			this.generations = 0;
			Backbone.on("tick", this.onTick, this);
		},
		render: function(){
			this.$el.html(this.generations);
			return this;
		},
		onTick: function(){
			this.generations++
			this.render();
		},
		clear: function(){
			this.generations = 0;
			this.render();
		}
	});
})();