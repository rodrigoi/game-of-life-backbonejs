var Application = Application || {};

if (typeof module !== "undefined" && module.exports) {
	var _ = _ || require("underscore");
	var Backbone = Backbone || require("backbone");

	module.exports = Application
	//very basic dependency injection, since in this case
	//Backbone must be shared with the test
	module.exports.use = function(Backbone){
		Backbone = Backbone
	}
}

(function(){
	"use strict";

	Application.Ticker = Backbone.Component.extend({
		tick: 50,
		timer:null,
		initialize: function(){
			Backbone.Component.prototype.initialize.apply(this, arguments);
		},
		start: function(){
			if(!this.timer){
				this.timer = setInterval(this.onTick, this.tick)
			}
		},
		stop: function(){
			if(this.timer){
				this.timer = clearInterval(this.timer);
			}
		},
		changeSpeed: function(newSpeed){
			this.tick = newSpeed;
			if(this.timer){
				this.stop()
				this.start()
			}
		},
		onTick: function(){
			Backbone.trigger("tick");
		}
	});
})();