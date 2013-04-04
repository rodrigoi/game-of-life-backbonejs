var Application = Application || {};
if (typeof require === "function" && typeof exports === "object" && typeof module === "object"){
	module.exports = Application
	Application = global.Application
}

(function(){
	"use strict";

	Application.WorldView = Backbone.View.extend({
		el: "div.world",
		initialize: function(options){
			options || (options = {});

			if(!options.collection){
				this.collection = new Application.World(null, {
					width: options.width,
					height: options.height
				});
			}
			//_.bindAll(this, "clearCells", "regenerate");
			Backbone.on("tick", this.regenerate, this);
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
		clear: function(){
			this.collection.clear();
		},
		randomize: function(){
			this.collection.randomize();
		}
	});
})();