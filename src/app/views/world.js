var Application = Application || {};

if (typeof module !== "undefined" && module.exports) {
	var jQuery = $ = jQuery || require("jquery");
	var _ = _ || require("underscore");
	var Backbone = Backbone || require("backbone");
	Backbone.$ = jQuery;

	Application = require("./cell");

	module.exports = Application;
}


(function(){
	"use strict";

	Application.WorldView = Backbone.View.extend({
		el: "div.world",
		initialize: function(){
			//_.bindAll(this, "clearCells", "regenerate");
			Backbone.on("tick", this.regenerate, this);
			Backbone.on("clear", this.clearCells, this);
		},
		render: function(){
			this.collection.each(function(cell){
				var cellView = new Application.CellView({model: cell});
				this.$el.append(cellView.render().el);
			}, this);

			return this;
		},
		regenerate: function(){
			this.collection.each(function(cell){
				cell.shouldBeAlive(this.collection.liveNeighbours(cell));
			}, this);
			Backbone.trigger("regenerate");
		},
		clearCells: function(){
			this.collection.each(function(cell){
				cell.set("alive", false);
			}, this);
		}
	});

})();