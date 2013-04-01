var Application = Application || {};

if (typeof module !== "undefined" && module.exports) {
	var _ = _ || require("underscore");
	var Backbone = Backbone || require("backbone");

	Application = require("../models/cell");

	module.exports = Application;
}

(function(){
	"use strict";

	Application.World = Backbone.Collection.extend({
		model: Application.Cell,
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
		}
	});

})();