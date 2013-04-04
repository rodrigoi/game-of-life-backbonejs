var Application = Application || {};

if (typeof require === "function" && typeof exports === "object" && typeof module === "object"){
	module.exports = Application
	Application = global.Application
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