var Application = Application || {};

if (typeof module !== "undefined" && module.exports) {
	var Backbone = Backbone || require("backbone");

	module.exports = Application;
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