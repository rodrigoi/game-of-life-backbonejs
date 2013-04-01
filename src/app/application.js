var Application = Application || {};

if (typeof module !== "undefined" && module.exports) {
	var _ = _ || require("underscore");
	var Backbone = Backbone || require("backbone");

	module.exports = Application;
}

(function(){
	"use strict";

	_.extend(Application, {
		width: 66,
		height: 20,
		worldView: null,
		ticker: null,
		initialize: function(){
			//initialize application view
			this.ticker = new Application.Ticker();

			var applicationView = new Application.AppView();
			applicationView.render();

			//initialize world view
			this.worldView = new Application.WorldView({
				collection: new Application.World(null, {
					width: this.width,
					height: this.height
				})
			});
			this.worldView.render();

			Backbone.on("save", this.save, this);
			Backbone.on("load", this.load, this);
			Backbone.on("randomize", this.randomize, this);
		},
		save: function(){
			localStorage.setItem("world", JSON.stringify({
				world: this.worldView.collection,
				width: this.width,
				height: this.height,
				type: "world"
			}));
		},
		load: function(){
			if(localStorage.world){
				var newWorld = new Application.World(JSON.parse(localStorage.world).world);

				for(var i = 0; i < this.worldView.collection.length; i++){
					var cell = this.worldView.collection.at(i);
					var newCellValue = newWorld.at(i).get("alive");
					if(cell.get("alive") !== newCellValue){
						cell.set("alive", newCellValue);
					}
				}
			}
		},
		randomize: function(){
			this.worldView.collection.each(function(item){
				item.set("alive", !!Math.round(Math.random() * 1));
			});
		}
	});

})();