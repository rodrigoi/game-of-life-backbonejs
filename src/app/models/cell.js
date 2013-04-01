var Application = Application || {};

if (typeof module !== "undefined" && module.exports) {
	var Backbone = Backbone || require("backbone");

	module.exports = Application;
}

(function(){
	"use strict";

	Application.Cell = Backbone.Model.extend({
		defaults: {
			x: 0,
			y: 0,
			alive: false,
			nextState: false
		},
		initialize: function(){
			Backbone.on("regenerate", this.regenerate, this);
		},
		toggleState: function(){
			this.set({ alive: !this.get("alive") });
		},
		shouldBeAlive: function(neighbours){
			if(this.get("alive")){
				this.set("nextState", neighbours !== 0 && neighbours === 2 || neighbours === 3)
			} else {
				this.set("nextState", neighbours === 3)
			}
		},
		regenerate: function(){
			this.set("alive", this.get("nextState"));
			this.set("nextState", false);
		}
	});

})();