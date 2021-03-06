var Application = Application || {};

if (typeof require === "function" && typeof exports === "object" && typeof module === "object"){
	module.exports = Application
	Application = global.Application
}

(function(){
	"use strict";

	Application.World = Backbone.Collection.extend({
		cellNeighbours: [
			[-1, -1], [0, -1], [1, -1],
			[-1,  0],          [1,  0],
			[-1,  1], [0,  1], [1,  1]
		],
		initialize: function(models, options){
			options || (options = {});
			this.width = options.width || 0;
			this.height = options.height || 0;

			if(!models) {
				for (var y = 0; y < this.height; y++) {
					for (var x = 0; x < this.width; x++){
						this.add(new Application.Cell({ x: x, y: y }));
					}
				};
			}
		},
		randomize: function(){
			this.each(function(model){
				model.set("alive", !!Math.round(Math.random() * 1));
			});
		},
		liveNeighbours: function(cell) {
			var x = cell.get("x");
			var y = cell.get("y");

			var livingNeighbours = _.filter(this.cellNeighbours, function(neighboursRelativeCoordinates){
				var neighbourX = neighboursRelativeCoordinates[0] + x;
				var neighbourY = neighboursRelativeCoordinates[1] + y;

				if(neighbourX < 0 || neighbourY < 0 || neighbourX > this.width - 1 || neighbourY > this.height - 1) {
					return false;
				}

				var neighbour = this.at(neighbourX + neighbourY * this.width);

				return neighbour ? neighbour.get("alive") : false;
			}, this);
			return livingNeighbours.length;
		},
		clear: function(){
			this.each(function(cell){
				cell.set("alive", false);
			}, this);
		},
		toJSON: function(){
			return JSON.stringify({
				world: this.where({ alive: true }).map(function(item){
					return {
						x: item.get("x"),
						y: item.get("y")
					};
				}),
				width: this.width,
				height: this.height,
				type: "world"
			});
		},
		updateFromJSON: function(json){
			var savedData = JSON.parse(json);
			this.updateFromSavedData(savedData);
		},
		updateFromSavedData: function(savedData){
			this.clear();
			_.each(savedData.world, function(item){
				var cell = this.at(item.x + item.y * savedData.width);

				if(cell) {
					cell.set("alive", true);
				}
			}, this);
		}
	});
})();